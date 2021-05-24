import os

class Config(object):
    dst_channels = str(os.environ.get('DST_CHANNEL')).split(',')
