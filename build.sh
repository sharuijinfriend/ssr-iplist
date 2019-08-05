#!/bin/bash
source /etc/profile
SOURCE="http://www.ipdeny.com/ipblocks/data/aggregated/cn-aggregated.zone"
#SOURCE="https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt"
#http://ipverse.net/ipblocks/data/countries/cn.zone
wget -O ip_ranges.txt "$SOURCE"
python3 ip-convert.py
