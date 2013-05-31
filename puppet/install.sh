#!/bin/bash

case "$1" in

#Install libdnet
libdnet )
cd /opt/snort/install
tar xf libdnet-1.12.tar
cd /opt/snort/install/libdnet-1.12
./configure; make; make install
if [ $? -gt 0 ]; then exit 1; fi
;;

#Compile PF_RING/kernel
pf_ring )
cd /opt/snort/install
tar zxf /opt/snort/install/PF_RING-5.5.1.tar.gz
ln -s /opt/snort/install/PF_RING-5.5.1 /opt/snort/install/PF_RING
ln -s /opt/snort/install/PF_RING-5.5.1 /root/PF_RING
cd /opt/snort/install/PF_RING/kernel
make; make install
if [ $? -gt 0 ]; then exit 1; fi
cd ../userland/lib
./configure; make; make install
if [ $? -gt 0 ]; then exit 1; fi
cd ../libpcap
./configure; make; make install; make install-shared
if [ $? -gt 0 ]; then exit 1; fi
ln -s /usr/local/lib/libpfring.so /usr/lib/libpfring.so
touch /opt/snort/install/PF_RING/.pf_ring
;;

#Insall daq
daq )
cd /opt/snort/install
tar zxf /opt/snort/install/daq-1.1.1.tar.gz
cd /opt/snort/install/daq-1.1.1
./configure; make; make install
if [ $? -gt 0 ]; then exit 1; fi
;;

#Compile pf_ring_daq
pf_ring_daq )
cd /opt/snort/install/PF_RING/userland/snort/pfring-daq-module
autoreconf -ivf; ./configure; make; make install
if [ $? -gt 0 ]; then exit 1; fi
touch /opt/snort/install/.pf_ring_daq
;;

#Install Snort
snort )
cd /opt/snort/install
tar zxf /opt/snort/install/snort-2.9.3.1.tar.gz
cd /opt/snort/install/snort-2.9.3.1
./configure --with-libpcap-includes=/usr/local/includes --with-libpcap-libraries=/usr/local/lib--with-libpfring-includes=/usr/local/include/--with-libpfring-libraries=/usr/local/lib--enable-zlib --enable-perfprofiling; make; make install
if [ $? -gt 0 ]; then exit 1; fi
;;

#Install Snort Rules
snort_rules )
cd /opt/snort
tar zxf install/snortrules-snapshot-2931.tar.gz
mkdir /usr/local/lib/snort_dynamicrules
cp /opt/snort/so_rules/precompiled/RHEL-6-0/x86-64/2.9.3.1/* /usr/local/lib/snort_dynamicrules/
if [ $? -gt 0 ]; then exit 1; fi
;;

#Install Snort Init Script
init )
/sbin/chkconfig --add pig
if [ $? -gt 0 ]; then exit 1; fi
/sbin/chkconfig pig on
if [ $? -gt 0 ]; then exit 1; fi
touch /opt/snort/install/.init
;;

#Install barnyard2
barnyard2 )
cd /opt/snort/install
tar zxf barnyard2-1.9.tar.gz
cd /opt/snort/install/barnyard2-1.9
./configure --with-mysql-libraries=/usr/lib64/mysql/; make; make install
if [ $? -gt 0 ]; then exit 1; fi
;;

#Clean up files in order to update PF_RING
cleanup_pf_ring )
rm -rf /opt/snort/install/PF_RING*
if [ $? -gt 0 ]; then exit 1; fi
rm -rf /root/PF_RING
if [ $? -gt 0 ]; then exit 1; fi
rm -f /opt/snort/install/PF_RING/.pf_ring
if [ $? -gt 0 ]; then exit 1; fi
rm -rf /usr/local/lib/daq
if [ $? -gt 0 ]; then exit 1; fi
rm -f /opt/snort/install/.pf_ring_daq
if [ $? -gt 0 ]; then exit 1; fi
rm -f /usr/local/bin/snort
if [ $? -gt 0 ]; then exit 1; fi
;;




esac