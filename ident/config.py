import os


class Config(object):
    IDENT_INTEGRATION_KEY = os.environ.get('IDENT_INTEGRATION_KEY')
    DB_USER = os.environ.get('DB_USER') or 'root'
    DB_PASSWORD = os.environ.get('DB_PASSWORD')
    DB_ADDRESS = os.environ.get('DB_ADDRESS') or '127.0.0.1'
    DB_PORT = os.environ.get('DB_PORT') or '3306'
    DB_NAME = os.environ.get('DB_NAME') or 'asteriskcdrdb'
    REDIS_HOST = os.environ.get('REDIS_HOST') or '127.0.0.1'
    REDIS_PORT = os.environ.get('REDIS_PORT') or '6379'
    REDIS_DB = os.environ.get('REDIS_DB') or '0'
    DOMAIN = os.environ.get('DOMAIN') or ''
    DIR_RECORD = os.environ.get('DIR_RECORD') or '0'
    IS_FIRST_SYNC = os.environ.get('IS_FIRST_SYNC') or '1'
    TYPE_DB = os.environ.get('DB_TYPE') or 'mysql'

