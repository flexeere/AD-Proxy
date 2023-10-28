#!/bin/bash

############################################################
# AD Proxy Installer
# Author: Flexeere
# Email: info@flexeere.com
# Github: https://github.com/flexeere/AD-Proxy/
# Web: https://flexeere.com
# If you need professional assistance, reach out to
# https://flexeere.com/order/contact.php
############################################################

if [ `whoami` != root ]; then
	echo "ERROR: You need to run the script as user root or add sudo before command."
	exit 1
fi

if [ ! -f /usr/bin/htpasswd ]; then
    echo "htpasswd not found"
    exit 1
fi

SQUID_USER=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 8 | head -n 1)
SQUID_PW=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

htpasswd -b -c /etc/squid/passwd $SQUID_USER $SQUID_PW > /dev/null 2>&1

sed -i 's/Squid proxy-caching web server/AD Proxy Service/g'  /etc/squid/squid.conf

systemctl restart squid > /dev/null 2>&1
systemctl restart squid3 > /dev/null 2>&1

echo -e "${NC}"
echo -e "${GREEN}Thank you for using AD Proxy Service.${NC}"
echo
echo -e "${CYAN}Username : ${SQUID_USER}${NC}"
echo -e "${CYAN}Password : ${SQUID_PW}${NC}"
echo -e "${CYAN}Port : 3128${NC}"
echo -e "${NC}"
