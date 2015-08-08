
#
# Configures logstash,kibana,elasticsearch daemon
# also requires that you enable https,ldap, and firewall management from the httpd module.
#
class logstash {
  require dns_client
  require yum
  require httpd
	
  ###install elastic search
  package { 'java-1.8.0-openjdk': ensure => 'installed', } ->
  package { 'elasticsearch': ensure => 'installed', } ->
  package { 'daemonize': ensure => 'installed', } -> # required for kibana init script
	
  file { '/etc/elasticsearch/elasticsearch.yml':
    ensure  => present,
    owner   => root,
    group   => root, 
    mode    => 0644,
    content => template("$module_name/elasticsearch.yml.erb"),
  } ~>
  service { "elasticsearch":
    enable     => true,
    ensure     => running,
    hasrestart => true,
  } ->
	
  ###install kibana
  file { '/etc/init.d/kibana':
    ensure  => present,
    owner   => root,
    group   => root, 
    mode    => 0755,
    content => template("$module_name/kibana.erb"),
  } ->
  exec { "pull down kibana install":
    command => "/usr/bin/wget http://enterprise_resources.telligen.us/packages/kibana-4.0.2-linux-x64.tar.gz -O /tmp/kibana-4.0.2-linux-x64.tar.gz",
    creates => "/opt/kibana",
  } ->
  exec { "decompress kibana":
    command => "/bin/tar -xf /tmp/kibana-4.0.2-linux-x64.tar.gz -C /opt/",
    creates => "/opt/kibana",
  } ->
  file {'/opt/kibana':
    ensure => 'link',
    target => '/opt/kibana-4.0.2-linux-x64',
  } ->
  file {'/tmp/kibana-4.0.2-linux-x64.tar.gz':
    ensure => 'absent',
  } ->
  file { '/opt/kibana/config/kibana.yml':
    ensure  => present,
    owner   => root,
    group   => root, 
    mode    => 0644,
    content => template("$module_name/kibana.yml.erb"),
  } 
  service { "kibana":
    enable     => true,
    ensure     => running,
    require => File['/opt/kibana/config/kibana.yml','/tmp/kibana-4.0.2-linux-x64.tar.gz','/opt/kibana','/etc/init.d/kibana'],
  }
  file { '/etc/httpd/conf.d/kibana.conf':
    ensure  => present,
    owner   => root,
    group   => root, 
    mode    => 0644,
    content => template("$module_name/kibana.conf.erb"),
  }  ~>
  exec { "reload httpd":
    command => "/etc/init.d/httpd reload",
    refreshonly => true,
  }
  ### still need to include logic for installing kibana into apache
  ###install logstash
  package { 'logstash': ensure => 'installed', } ->
  firewall { "330 syslog UDP in":
    chain => 'INPUT',
    port => 5014,
    proto => udp,
    action => accept,
  } ->
  firewall { "331 syslog JSON UDP in":
    chain => 'INPUT',
    port => 5015,
    proto => udp,
    action => accept,
  } ->
  file { '/etc/logstash/conf.d/02-syslog-input.conf':
    ensure  => present,
    owner   => root,
    group   => root, 
    mode    => 0644,
    notify  => Service['logstash'],
    content => template("$module_name/02-syslog-input.conf.erb"),
  } ->
  file { '/etc/logstash/conf.d/03-syslog-input.conf':
    ensure  => present,
    owner   => root,
    group   => root, 
    mode    => 0644,
    notify  => Service['logstash'],
    content => template("$module_name/03-syslog-input.conf.erb"),
  } ->
  file { '/etc/logstash/conf.d/10-syslog.conf':
    ensure  => present,
    owner   => root,
    group   => root, 
    mode    => 0644,
    notify  => Service['logstash'],
    content => template("$module_name/10-syslog.conf.erb"),
  } ->
  file { '/etc/logstash/conf.d/30-syslog-output.conf':
    ensure  => present,
    owner   => root,
    group   => root, 
    mode    => 0644,
    notify  => Service['logstash'],
    content => template("$module_name/30-syslog-output.conf.erb"),
  } ->
  service { "logstash":
    enable     => true,
    ensure     => running,
    hasrestart => true,
  }
}
