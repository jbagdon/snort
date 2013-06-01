###Puppet install of Snort with Barnyard2, Oinkmaster, and PF_RING.

### Description
The files contained in this repository will install Snort, Barnyard2, Oinkmaster, and PF_RING. Snort is one of the best Network Intrusion Detection systems out there (my opinion). PF_RING allows many Snort processes to be run on a single host all listening for traffic on the same interface. I currently administer a host that consists of 16 Snort processes inspecting traffic at rates of 600 packets per second. This system is highly scalable and has no issues keeping up.

### Install
* git clone to local host/server.
* Copy the puppet directory to /root/ so you end up with /root/puppet/
* run puppet with 'puppet apply snort.pp'

### Where does this all get installed and how is it run?
Most of the files will be installed in /opt/snort with the exception of the binaries for snort, barnyard, and oinkmaster. Please look at snort.pp and the install.sh script to see where everything gets placed.

### Changes to config files
Any changes to the config files should be done in the puppet directory. Run puppet again and it will change all the files that need to be changed in the destination directories.

### Upgrading
Please look at the install.sh script. There are commands that will uninstall check files that puppet looks for when binaries are initially installed. Running these commands will remove the check files needed to reinstall or upgrade different aspects of your system.
