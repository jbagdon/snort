#!/bin/bash

cd /opt/snort/etc
sed -e 's/pig-01/pig-01/' -e 's/waldo01/waldo01/' barnyard2.conf > barnyard2.conf.tmp
mv barnyard2.conf.tmp barnyard2.conf01
sed -e 's/pig-01/pig-02/' -e 's/waldo01/waldo02/' barnyard2.conf > barnyard2.conf.tmp
mv barnyard2.conf.tmp barnyard2.conf02
sed -e 's/pig-01/pig-03/' -e 's/waldo01/waldo03/' barnyard2.conf > barnyard2.conf.tmp
mv barnyard2.conf.tmp barnyard2.conf03
sed -e 's/pig-01/pig-04/' -e 's/waldo01/waldo04/' barnyard2.conf > barnyard2.conf.tmp
mv barnyard2.conf.tmp barnyard2.conf04
sed -e 's/pig-01/pig-05/' -e 's/waldo01/waldo05/' barnyard2.conf > barnyard2.conf.tmp
mv barnyard2.conf.tmp barnyard2.conf05
sed -e 's/pig-01/pig-06/' -e 's/waldo01/waldo06/' barnyard2.conf > barnyard2.conf.tmp
mv barnyard2.conf.tmp barnyard2.conf06
sed -e 's/pig-01/pig-07/' -e 's/waldo01/waldo07/' barnyard2.conf > barnyard2.conf.tmp
mv barnyard2.conf.tmp barnyard2.conf07
sed -e 's/pig-01/pig-08/' -e 's/waldo01/waldo08/' barnyard2.conf > barnyard2.conf.tmp
mv barnyard2.conf.tmp barnyard2.conf08
sed -e 's/pig-01/pig-09/' -e 's/waldo01/waldo09/' barnyard2.conf > barnyard2.conf.tmp
mv barnyard2.conf.tmp barnyard2.conf09
sed -e 's/pig-01/pig-10/' -e 's/waldo01/waldo10/' barnyard2.conf > barnyard2.conf.tmp
mv barnyard2.conf.tmp barnyard2.conf10
sed -e 's/pig-01/pig-11/' -e 's/waldo01/waldo11/' barnyard2.conf > barnyard2.conf.tmp
mv barnyard2.conf.tmp barnyard2.conf11
sed -e 's/pig-01/pig-12/' -e 's/waldo01/waldo12/' barnyard2.conf > barnyard2.conf.tmp
mv barnyard2.conf.tmp barnyard2.conf12
