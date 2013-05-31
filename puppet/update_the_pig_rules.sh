#!/bin/bash

update=$(/usr/local/bin/oinkmaster.pl -o /opt/snort/rules > /opt/snort/oinkmaster.log)
if [ $? -eq 0 ]
     then
          /etc/init.d/pig restart
fi
