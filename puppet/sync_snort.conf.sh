#!/bin/bash

cd /opt/snort/etc
sed -e 's/alert.log,/alert.log01,/' snort.conf > snort.conf.tmp
mv snort.conf.tmp snort.conf01
sed -e 's/alert.log,/alert.log02,/' snort.conf > snort.conf.tmp
mv snort.conf.tmp snort.conf02
sed -e 's/alert.log,/alert.log03,/' snort.conf > snort.conf.tmp
mv snort.conf.tmp snort.conf03
sed -e 's/alert.log,/alert.log04,/' snort.conf > snort.conf.tmp
mv snort.conf.tmp snort.conf04
sed -e 's/alert.log,/alert.log05,/' snort.conf > snort.conf.tmp
mv snort.conf.tmp snort.conf05
sed -e 's/alert.log,/alert.log06,/' snort.conf > snort.conf.tmp
mv snort.conf.tmp snort.conf06
sed -e 's/alert.log,/alert.log07,/' snort.conf > snort.conf.tmp
mv snort.conf.tmp snort.conf07
sed -e 's/alert.log,/alert.log08,/' snort.conf > snort.conf.tmp
mv snort.conf.tmp snort.conf08
sed -e 's/alert.log,/alert.log09,/' snort.conf > snort.conf.tmp
mv snort.conf.tmp snort.conf09
sed -e 's/alert.log,/alert.log10,/' snort.conf > snort.conf.tmp
mv snort.conf.tmp snort.conf10
sed -e 's/alert.log,/alert.log11,/' snort.conf > snort.conf.tmp
mv snort.conf.tmp snort.conf11
sed -e 's/alert.log,/alert.log12,/' snort.conf > snort.conf.tmp
mv snort.conf.tmp snort.conf12
