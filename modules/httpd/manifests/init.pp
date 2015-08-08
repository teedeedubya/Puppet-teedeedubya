# Basic HTTPD puppet module.  Currently just verifies 

class httpd (
  $httpd_ssl = "false",
  $httpd_ldap = "false",
  $httpd_firewall = "false",
  ){
  require dns_client
  require yum

  package { 'httpd': 
	ensure => 'installed',
  } ->
  service { "httpd":
    enable     => true,
    ensure     => running,
    hasrestart => true,
  }
  if $httpd_firewall == "true"{
    firewall { "320 HTTP in":
      chain => 'INPUT',
      port => 80,
      proto => tcp,
      action => accept,
    }
  }
  if $httpd_ldap == "true" {
    package { 'mod_authz_ldap': 
	  ensure => 'installed',
	  notify => Service[httpd],
    }
  }
  if $httpd_ssl == "true" {
    if $httpd_firewall == "true" {
      firewall { "221 HTTPS in":
       chain => 'INPUT',
       port => 443,
       proto => tcp,
       action => accept,
      } 
    }
    package { 'mod_ssl': 
	  ensure => 'installed',
	  notify => Service[httpd],
    }
    file { '/etc/httpd/conf.d/ssl.conf':
      ensure  => present,
	  owner   => root,
      group   => root, 
      mode    => 0644,
      notify  => Service[httpd],
      content => template("$module_name/ssl.conf.erb"),
    }
    file { "/etc/httpd/ssl":
      ensure => "directory",
      owner  => "root",
      group  => "root",
      mode   => 755,
    } ->
    file { "/etc/httpd/ssl/gd_bundle.crt":
      ensure => present,
	  owner => "root",
	  group => "root",
      mode   => '644',
      source => "puppet:///modules/$module_name/gd_bundle.crt",
    } ->
    file { "/etc/httpd/ssl/telligen.us.crt":
      ensure => present,
      owner => "root",
      group => "root",
      mode   => '644',
      source => "puppet:///modules/$module_name/telligen.us.crt",
    } ->
    file { "/etc/httpd/ssl/telligen.us.key":
      ensure => present,
      owner => "root",
      group => "root",
      mode   => '644',
      notify  => Service[httpd],
      source => "puppet:///modules/$module_name/telligen.us.key",
    }	
  }
  
  file { '/etc/httpd/conf.d/apachestatus.conf':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
	require => Package['httpd'],
    content => template("$module_name/apachestatus.conf.erb"),
  } ~>
  exec { "reload":
	command => "/etc/init.d/httpd reload",
	require => file['/etc/httpd/conf.d/apachestatus.conf'],
	refreshonly => true,
  }
}