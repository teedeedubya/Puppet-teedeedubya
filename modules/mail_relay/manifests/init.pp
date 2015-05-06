#
# class that sets up a mail relay
#

class mail_relay {
  require dns_client
  require yum
  
  package { "postfix": ensure => 'installed', }
  ->
  file { "/etc/postfix/main.cf":
    ensure => present,
	owner => "root",
	group => "root",
    mode   => '644',
    source => "puppet:///modules/$module_name/main.cf",
  }
  ~>
  service { "postfix":
    ensure     => running,
    enable     => true,
    hasrestart => true
  }
}
