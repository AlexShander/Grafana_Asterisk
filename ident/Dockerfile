FROM python:3.9.5-alpine3.13

LABEL maintainer="Alexandr Shander <alexmasc05@gmail.com>"

RUN sed -i 's/https/http/g' /etc/apk/repositories 

RUN apk add ca-certificates --no-cache && apk add --no-cache python3-dev build-base linux-headers pcre-dev \
     postgresql-dev && rm -rf /var/cache/apk/*
RUN /usr/local/bin/python -m pip install --upgrade --no-cache-dir pip && pip3 install --no-cache-dir uwsgi flask
WORKDIR /ident_asterisk_cdr
COPY requirements.txt /ident_asterisk_cdr/
RUN pip3 install -r requirements.txt
COPY ./README.md /ident_asterisk_cdr/
COPY ./config.py /ident_asterisk_cdr/
COPY ./ident_cdr.py /ident_asterisk_cdr/
COPY ./app/ /ident_asterisk_cdr/app/
COPY ./cdr/ /ident_asterisk_cdr/cdr/

ENTRYPOINT ["uwsgi", "--socket=0.0.0.0:8080", "--protocol=http", "-w", "ident_cdr:app"]

EXPOSE 8080
