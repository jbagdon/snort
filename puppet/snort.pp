Package { ensure => "installed" }

package { "autoconf": }
package { "automake": }
package { "pcre-devel": }
package { "libpcap-devel": }
package { "gcc": }
package { "gcc-c++": }
package { "make": }
package { "zlib-devel": }
package { "flex": }
package { "bison": }
package { "libtool": }
package { "kernel-uek-devel": }
package { "mysql-devel": }

#Create snort directory
file { "/opt/snort":
    ensure => "directory",
    require => [ Package["autoconf"],
                Package["automake"],
                Package["pcre-devel"],
                Package["libpcap-devel"],
                Package["gcc"],
                Package["gcc-c++"],
                Package["make"],
                Package["zlib-devel"],
                Package["flex"],
                Package["bison"],
                Package["libtool"],
                Package["kernel-uek-devel"],
                Package["mysql-devel"],
                ],
}

file { "/opt/snort/etc":
    ensure => "directory",
    require => File["/opt/snort"],
}

#Create install directory
file { "/opt/snort/install":
    ensure => "directory",
    require => File["/opt/snort"],
}

#Get install script
file { "/opt/snort/install/install.sh":
    ensure => 'file',
    source => '/root/puppet/install.sh',
    mode   => 700,
    require => File["/opt/snort/install"],
}

#Install libdnet
file { "/opt/snort/install/libdnet-1.12.tar":
    source => '/root/puppet/libdnet-1.12.tar',
    require => File["/opt/snort/install/install.sh"],
}

exec { "Install_libdnet":
    command => "/opt/snort/install/install.sh libdnet",
    require => File["/opt/snort/install/libdnet-1.12.tar"],
    creates => "/usr/local/lib/libdnet"
}

#Get PF_RING
file { "/opt/snort/install/PF_RING-5.5.1.tar.gz":
    source  => '/root/puppet/PF_RING-5.5.1.tar.gz',
    require => Exec[Install_libdnet],
}

#Compile PF_RING kernel module
exec { "pf_ring":
    command => "/opt/snort/install/install.sh pf_ring",
    require => File["/opt/snort/install/PF_RING-5.5.1.tar.gz"],
    creates => "/opt/snort/install/PF_RING/.pf_ring",
}

#Get daq
file { "/opt/snort/install/daq-1.1.1.tar.gz":
    source => '/root/puppet/daq-1.1.1.tar.gz',
    require => Exec[pf_ring],
}

#Install daq
exec {"install_daq":
    command => "/opt/snort/install/install.sh daq",
    require => File["/opt/snort/install/daq-1.1.1.tar.gz"],
    creates => "/usr/local/lib/daq"
}

exec { "pf_ring_daq":
    command => "/opt/snort/install/install.sh pf_ring_daq",
    require => Exec[install_daq],
    creates => "/opt/snort/install/.pf_ring_daq"
}

#Install Snort
file { "/opt/snort/install/snort-2.9.3.1.tar.gz":
    ensure => 'file',
    source => "/root/puppet/snort-2.9.3.1.tar.gz",
}

exec { "install_snort":
    command => "/opt/snort/install/install.sh snort",
    require => Exec[pf_ring_daq],
    creates => "/usr/local/bin/snort",
}

#Install Snort Rules
file { "/opt/snort/install/snortrules-snapshot-2931.tar.gz":
    ensure => 'file',
    source => "/root/puppet/snortrules-snapshot-2931.tar.gz",
    require => File["/opt/snort/install"],
}

exec { "install_snort_rules":
    command => "/opt/snort/install/install.sh snort_rules",
    require => File["/opt/snort/install/snortrules-snapshot-2931.tar.gz"],
    creates => "/opt/snort/rules",
}

#Create logging directory
file { "/var/log/snort":
    ensure => 'directory',
}

#Install oinkmaster
file { "/usr/local/bin/oinkmaster.pl":
    ensure => 'file',
    source => "/root/puppet/oinkmaster.pl",
    mode   => 700,
    owner  => "root",
    group  => "root",
}

file { "/etc/oinkmaster.conf":
    ensure => 'file',
    source => "/root/puppet/oinkmaster.conf",
    mode   => 644,
    owner  => "root",
    group  => "root",
}

file { "/opt/snort/update_the_pig_rules.sh":
    ensure => 'file',
    source => "/root/puppet/update_the_pig_rules.sh",
    mode   => 755,
    owner  => "root",
    group  => "root",
}

#Install Snort Init Script
file { "/etc/init.d/pig":
    ensure => 'file',
    source => "/root/puppet/pig",
    mode   => 755,
    owner  => "root",
    group  => "root",
}

exec { "install_init":
    command => "/opt/snort/install/install.sh init",
    require => File["/etc/init.d/pig"],
    creates => "/opt/snort/install/.init",
}

#Install barnyard2
file { "/opt/snort/install/barnyard2-1.9.tar.gz":
    ensure  => 'file',
    source  => "/root/puppet/barnyard2-1.9.tar.gz",
    require => File["/opt/snort/install"],
}

exec { "install_barnyard2":
    command => "/opt/snort/install/install.sh barnyard2",
    creates => "/usr/local/bin/barnyard2",
    require => File["/opt/snort/install/barnyard2-1.9.tar.gz"],
}

file { "/opt/snort/etc/barnyard2.conf":
    ensure  => 'file',
    source  => "/root/puppet/barnyard2.conf",
    mode    => 644,
    owner   => "root",
    group   => "root",
    require => Exec[install_snort_rules],
}

exec { "/opt/snort/etc/sync_barnyard2.conf.sh":
    subscribe => File["/opt/snort/etc/barnyard2.conf"],
    refreshonly => true,
}

file { "/opt/snort/etc/sync_barnyard2.conf.sh":
    ensure  => 'file',
    source  => "/root/puppet/sync_barnyard2.conf.sh",
    mode    => 755,
    owner   => "root",
    group   => "root",
    require => Exec[install_snort_rules],
}

#Install Snort Config Files
file { "/opt/snort/etc/snort.conf":
    ensure  => 'file',
    source  => "/root/puppet/snort.conf",
    mode    => 644,
    owner   => "root",
    group   => "root",
    require => Exec[install_snort_rules],
}

exec { "/opt/snort/etc/sync_snort.conf.sh":
    subscribe => File["/opt/snort/etc/snort.conf"],
    refreshonly => true,
}

file { "/opt/snort/etc/sync_snort.conf.sh":
    ensure  => 'file',
    source  => "/root/puppet/sync_snort.conf.sh",
    mode    => 755,
    owner   => "root",
    group   => "root",
    require => Exec[install_snort_rules],
}

file { "/opt/snort/etc/threshold.conf":
    ensure  => 'file',
    source  => "/root/puppet/threshold.conf",
    mode    => 644,
    owner   => "root",
    group   => "root",
    require => Exec[install_snort_rules],
}