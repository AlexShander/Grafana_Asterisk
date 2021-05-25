from sqlalchemy import create_engine
from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import DateTime
from sqlalchemy.sql import and_, or_, not_
from sqlalchemy import dialects
from sqlalchemy import null
from sqlalchemy import select
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import union
from sqlalchemy import join
from sqlalchemy import sql
from sqlalchemy import outerjoin
from datetime import datetime
from cdr.tables import QueueLogForExcel
from cdr.tables import CDRViewer
from cdr.datasets import Cdr
from cdr.tables import Operators
from cdr.config import Config


class DBCdr(object):
    def __init__(self, db_user='asterisk', db_password='password',
                 db_address='127.0.0.1', db_port='3306',
                 db_name='asteriskcdrdb',
                 domain='', dir_record='', db_type='mysql',):
        self.db_user = db_user
        self.db_password = db_password
        self.db_name = db_name
        self.db_address = db_address
        self.db_port = db_port
        self.domain = domain
        self.dir_record = str(dir_record)
        self.db_type = db_type;
        if db_type == 'mysql':
            self.engine = create_engine(u"mysql+pymysql://{}:{}@{}:{}/{}".format(self.db_user,
                                        self.db_password, self.db_address, self.db_port,
                                        self.db_name), echo=True)
        else:
            self.engine = create_engine(u"postgresql+pygresql://{}:{}@{}:{}/{}".format(self.db_user,
                                                                                       self.db_password,
                                                                                       self.db_address,
                                                                                       self.db_port,
                                                                                       self.db_name), echo=True)

    def change_file_url(self, record_file_name=''):
        if record_file_name is not None:
            del_path_file_name = record_file_name.replace(self.dir_record, '', 1)
            url_file_name = f"{self.domain}{del_path_file_name}"
            return url_file_name
        else:
            return None

    def get_operators_dict(self, conn) -> dict:
        stmnt_operators_select = select([Operators.name.label('name'),
                                        Operators.num.label('num')]).limit(1000)
        results = conn.execute(stmnt_operators_select).fetchall()
        operators_dict = dict()
        for operator in results:
            operators_dict[operator[1]] = operator[0]
        return operators_dict

    def get_cdrs(self, start_date: datetime, stop_date: datetime, limit=500, offset=0):
        conn = self.engine.connect()
        regexp_op = 'REGEXP' if self.db_type = 'mysql' else '~*'
        operators_dict = self.get_operators_dict(conn)
        stmnt_queuelog = select([QueueLogForExcel.time.label('calldate'),
                                sql.expression.literal_column("\'in\'", String).label('direction'),
                                QueueLogForExcel.CLID_Client.label('src'),
                                QueueLogForExcel.DID.label('dst'),
                                QueueLogForExcel.Wait_Time.label('wait_time'),
                                QueueLogForExcel.billsec.label('billsec'),
                                CDRViewer.recordingfile,
                                QueueLogForExcel.agent.label('LineDescription')]).select_from(
                                    join(QueueLogForExcel, CDRViewer, 
                                         and_(
                                              QueueLogForExcel.callid == CDRViewer.linkedid,
                                              QueueLogForExcel.agent == CDRViewer.realdst
                                              ),
                                         isouter=True)).where(and_(QueueLogForExcel.time >= start_date,
                                                                   QueueLogForExcel.time <= stop_date))
        dst_channel_pattern = "|".join(Config.dst_channels)
        stmnt_cdr = select([CDRViewer.calldate.label('calldate'),
                            sql.expression.literal_column("\'out\'", String).label('direction'),
                            CDRViewer.did.label('src'),
                            CDRViewer.realdst.label('dst'),
                            CDRViewer.duration.op('-')(CDRViewer.billsec).label('wait_time'),
                            CDRViewer.billsec.label('billsec'),
                            CDRViewer.recordingfile,
                            CDRViewer.src.label('LineDescription')]).where(
                                       and_
                                       (
                                        CDRViewer.calldate >= start_date, 
                                        CDRViewer.calldate <= stop_date,
                                        CDRViewer.dstchannel.op(regexp_op)(dst_channel_pattern)
                                        )
                                      )
        select_union = union(stmnt_queuelog, stmnt_cdr).limit(limit).offset(int(offset))
        results = conn.execute(select_union).fetchall()
        conn.close()
        list_cdr = []
        for db_cdr in results:
            list_cdr.append(Cdr(db_cdr[0], db_cdr[1], db_cdr[2], 
                            db_cdr[3], int(db_cdr[4]), int(db_cdr[5]), 
                            self.change_file_url(record_file_name=db_cdr[6]),
                            db_cdr[7], operators_dict).__dict__
                           )
        return list_cdr

