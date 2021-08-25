#!/bin/bash
echo 
echo Get main interface
echo 
defint=$(ip route show | grep default  | head -n1 | awk '{print $5}')
hostip=$(ip addr show dev $defint | grep "inet" | awk 'NR==1{print $2}' | cut -d'/' -f 1)
hostsub=$(ip route | grep "src $hostip" | awk '{print $1}')
hostgate=$(ip route show | grep default | head -n1 | awk '{print $3}')
read -p "Subnet (default "$hostsub"): " sub
sub=${sub:=$hostsub}
read -p 'Gateway (default '$hostgate'): ' gate
gate=${gate:=$hostgate}
read -p 'Asterisk address: ' ip
last=`echo $ip | cut -d . -f 4`
begin=`echo $ip | cut -d"." -f1-3`
read -p 'Ethernet interface (default '$defint'): ' eth
eth=${eth:=$defint}
read -p 'Docker Network Name: (default vip-'$last'): ' name
name=${name:="vip-"$last}
echo -e "Build the network on each node, \033[0;33mmake sure the physical parent interface (parent=) is set properly on each node if different)\033[0m:"
echo -e "        \033[44mdocker network create --config-only --subnet $sub --gateway $gate --ip-range $ip/32 -o parent=$eth $name\033[0m"
docker network create --config-only --subnet $sub --gateway $gate --ip-range $ip/32 -o parent=$eth $name
echo
echo "Then create the swarm network from any manager node:"
echo -e "        \033[44mdocker network create -d macvlan --scope swarm --config-from $name swarm-asterisk\033[0m"
docker network create -d macvlan --scope swarm --config-from $name swarm-asterisk
echo 
echo "Create Volumes for nginx and cerbot, its containe letsencrypt certs. List of volumes:"
echo -e "\033[44m letsencrypt,\033[0m"
echo -e "\033[44m well-known,\033[0m"
echo -e "\033[44m lib-letsencrypti.\033[0m"
docker volume create letsencrypt 
docker volume create well-known 
docker volume create lib-letsencrypt
echo 
echo "Add to cron a new job with renew ssl at 00:19 & 12:19 each day"
echo
touch /var/spool/cron/certbot
/usr/bin/crontab /var/spool/cron/certbot
echo "19 0,12 * * * $PWD/../nginx/certbot_updateall.sh" > /var/spool/cron/certbot
echo -n
read -p "Input \033[IDENT_INTEGRATION_KEY:\033[0m" IDENT_INTEGRATION_KEY
export IDENT_INTEGRATION_KEY=$IDENT_INTEGRATION_KEY
echo
echo "Deploy services"
echo
docker stack deploy -c callcenter.yml callcenter
