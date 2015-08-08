#
# class that sets up an ntp client
#

class ntp_client {
  require dns_client
  require yum
  
  package { "ntp": ensure => 'installed', }
  ->
  file { "/etc/ntp.conf":
    ensure => present,
	owner   => "root",
	group   => "wheel",
    mode   => '644',
    source => "puppet:///modules/$module_name/ntp.conf",
	require => Package["ntp"],
  }
  ~>
  service { "ntpd":
    ensure     => running,
    enable     => true,
    hasrestart => true
  }
  
}
