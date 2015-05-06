
#
# Configures snmpd
#
class snmpd {
  require dns_client
  require yum
  
  package { 'net-snmp': ensure => 'installed', } ->
  package { 'net-snmp-utils': ensure => 'installed', } ->
  file { '/etc/snmp/snmpd.conf':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    notify  => Service['snmpd'],
    content => template("$module_name/snmpd.conf.erb"),
  } ~>
  service { "snmpd":
    enable     => true,
    ensure     => running,
    hasrestart => true,
  }
}