#!/bin/sh

reload_nginx_config(){
  while true
  do
    sleep 6h 
    nginx -s reload
  done
}

reload_nginx_config &
