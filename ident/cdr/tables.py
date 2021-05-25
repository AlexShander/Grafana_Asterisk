from sqlalchemy.ext.declarative import declarative_base
Base = declarative_base()

from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import DateTime


class QueueLogForExcel(Base):
    __tablename__ = 'cdr_queue_log'
    id = Column(Integer, primary_key=True)
    time = Column(DateTime)
    CLID_Client = Column(String)
    DID = Column(String)
    billsec = Column(Integer)
    Wait_Time = Column(Integer)
    callid = Column(String)
    agent = Column(String)


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
    recordingfile = Column(String)
    did = Column(String)


class Operators(Base):
    __tablename__ = 'operators'
    id = Column(Integer, primary_key=True)
    name = Column(String)
    num = Column(Integer)
