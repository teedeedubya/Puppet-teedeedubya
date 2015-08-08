#
# Configures auditd
#
class infra2_os::auditd {  
  require dns_client
  require yum
  
  package { 'audit': ensure => 'latest', } ->
  package { 'audit-libs': ensure => 'latest', } ->
  file { '/etc/audit/auditd.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0640,
    notify  => Service[auditd],
	before  => Service[auditd],
    content => template("$module_name/auditd.conf.erb"),
  }
 file { '/etc/audit/audit.rules':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0640,
    notify  => Service[auditd],
	before  => Service[auditd],
    content => template("$module_name/audit.rules.erb"),
  }
 file { '/etc/audit/rules.d':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 0760,
    notify  => Service[auditd],
	before  => Service[auditd],
  }   
  service { "auditd":
    enable     => true,
    ensure     => running,
    hasrestart => true,
  }
}