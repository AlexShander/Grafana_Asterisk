#!/bin/bash

set -x

AMI_USER=userevents AMI_PASSWORD=password AMI_ADDRESS=asterisk IS_FIRST_SYNC=0 IDENT_INTEGRATION_KEY=secretIdent \
DB_USER=asterisk DB_PASSWORD=password DB_ADDRESS=asterisk-db DOMAIN="https://$(hostname)/calls/records/"  \
DIR_RECORD="/var/spool/asterisk/monitor/" DB_NAME=asteriskcdrdb docker-compose up -d --build
