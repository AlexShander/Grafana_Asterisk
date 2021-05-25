from sqlalchemy.ext.declarative import declarative_base
Base = declarative_base()

from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import DateTime


class QueueLogForExcel(Base):
    __tablename__ = 'cdr_queue_log'
    calldate = Column(DateTime)
    uniqueid = Column(String)
    queuename = Column(String)
    dst = Column(String)
    disposition = Column(String)
    billsec = Column(String)
    did = Column(String)
    src = Column(String)
    wait_time = Column(String)
    filename = Column(String)


class CDRViewer(Base):
    __tablename__ = 'cdr'
    id = Column(Integer, primary_key=True)
    calldate = Column(DateTime)
    src = Column(String)
    realdst = Column(String)
    billsec = Column(Integer)
    duration = Column(Integer)
    dstchannel = Column(String)
    linkedid = Column(String)
    filename = Column(String)
    did = Column(String)


class Operators(Base):
    __tablename__ = 'operators'
    id = Column(Integer, primary_key=True)
    name = Column(String)
    num = Column(Integer)
