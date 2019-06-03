#
# misc_securty_benchmarks is a class to manage all the little changes 
# that compliance requires that aren't worth making into their own module
#

class infra2_os::misc_securty_benchmarks {
  require infra2_os::telligen
  file { "/opt/telligen/scripts/puppet":
    ensure => "directory",
	owner  => "root",
    group  => "root",
	mode => "0755",
  }
  # CIS Benchmark 5.5.3
  file { '/etc/hosts.allow':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => '0644',
  }
  # CIS Benchmark 5.5.5
  file { '/etc/hosts.deny':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => '0644',
  }
  # CIS Benchmark 2.1.2
  package { 'telnet': ensure => 'absent', }

  # Blacklisted packages and services
  package { 'sendmail': ensure => 'absent', }
  package { 'telnet-server': ensure => 'absent', }
  package { 'rsh-server': ensure => 'absent', }
  package { 'rsh': ensure => 'absent', }
  package { 'ypserv': ensure => 'absent', }
  package { 'ypbind': ensure => 'absent', }
  package { 'tftp-server': ensure => 'absent', }
  package { 'tftp': ensure => 'absent', }
  package { 'talk-server': ensure => 'absent', }
  package { 'talk': ensure => 'absent', }
  package { 'xinetd': ensure => 'absent', }
  package { 'dhcp': ensure => 'absent', }
  package { 'dovecot': ensure => 'absent', }

  exec { "Remove X Window System": 
    command => '/usr/bin/yum groupremove -y "X Window System"',
    onlyif  => '/usr/bin/yum grouplist "X Window System" | /bin/grep "Installed Groups"'
  }

  service { 'chargen-dgram': ensure => 'stopped', enable => false}
  service { 'chargen-stream': ensure => 'stopped', enable => false}
  service { 'daytime-dgram': ensure => 'stopped', enable => false}
  service { 'daytime-stream': ensure => 'stopped', enable => false}
  service { 'echo-dgram': ensure => 'stopped', enable => false}
  service { 'echo-stream': ensure => 'stopped', enable => false}
  service { 'tcpmux-server': ensure => 'stopped', enable => false}
  # service { 'avahi-daemon': ensure => 'stopped', enable => false} #already being set in infra2os::disable_avahi
  service { 'cups': ensure => 'stopped', enable => false}

  # CIS Benchmark 9.1.2, 9.1.3, 9.1.4, 9.1.5, 9.1.6, 9.1.7, 9.1.8, 9.1.9  
  file {
    "/etc/passwd":
      owner => "root",
      group => "root",
      mode => '644';
    "/etc/group":
      owner => "root",
      group => "root",
      mode => '644';
    "/etc/shadow":
      owner => "root",
      group => "root",
      mode => '000';
    "/etc/gshadow":
      owner => "root",
      group => "root",
      mode => '000';
    "/etc/libuser.conf":
      owner => "root",
      group => "root",
      mode => '644'; 
  }

  #STIG - disable TIPC RHEL-06-000127
  file { '/etc/modprobe.d/tipc.conf':
    content => "install tipc /bin/true",
    owner => "root",
    group => "root",
    mode => '644',
  }
}
