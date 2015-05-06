
#
# Configures zabbix-agent (system monitoring)
#
class zabbix_agent {
  require dns_client
  require yum
  
  package { 'zabbix-agent': ensure => 'installed', } ->
  file { '/etc/zabbix/zabbix_agentd.conf':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0600,
    notify  => Service[zabbix-agent],
    content => template("$module_name/zabbix_agentd.conf.erb"),
  } ~>
  service { "zabbix-agent":
    enable     => true,
    ensure     => running,
    hasrestart => true,
  }
  file { '/etc/zabbix/zabbix_agentd.d/userparameter_diskstats.conf':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    notify  => Service[zabbix-agent],
	require => Package['zabbix-agent'],
    content => template("$module_name/userparameter_diskstats.conf.erb"),
  }
  file { '/etc/zabbix/zabbix_agentd.d/userparameter_jolokiajmx.conf':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    notify  => Service[zabbix-agent],
	require => Package['zabbix-agent'],
    content => template("$module_name/userparameter_jolokiajmx.conf.erb"),
  }
  file { '/opt/telligen/scripts/lld-disks.py':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0755,
	require => Package['zabbix-agent'],
    content => template("$module_name/lld-disks.py.erb"),
  }
  file { '/opt/telligen/scripts/jolokia_jmx_discovery.py':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0755,
	require => Package['zabbix-agent'],
    content => template("$module_name/jolokia_jmx_discovery.py.erb"),
  }
  file { '/opt/telligen/scripts/jolokia_jmx_read.py':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0755,
	require => Package['zabbix-agent'],
    content => template("$module_name/jolokia_jmx_read.py.erb"),
  }
}