#
# Configures auditd
#
class infra2_os::auditd (
$service_shutdown = hiera('service_shutdown', false),
$major_release = $::facts['os']['release']['major']
) {
  require infra2_os::telligen
  require dns_client
  require yum

  package { 'audit': ensure => 'latest', } ->
  package { 'audit-libs': ensure => 'latest', } ->

  file { '/etc/audit/auditd.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0640',
    before  => Service[auditd],
    content => template("$module_name/auditd.conf.erb"),
  }
  if $operatingsystemmajrelease == '6' {
    file { '/etc/audit/audit.rules':
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0640',
      notify  => Service[auditd],
      before  => Service[auditd],
      content => template("$module_name/audit.rules.erb"),
    }
    file { '/etc/init.d/auditd':
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '755',
      content => template("$module_name/auditd.init.erb"),
    }
  }
  file { '/etc/audit/rules.d':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0760',
    before  => Service[auditd],
  }
  if $operatingsystemmajrelease == '7' {
    file { '/etc/audit/rules.d/audit.rules':
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0640',
      before  => Service[auditd],
      content => template("$module_name/audit.rules.erb"),
    } ~>
    exec { 'Kill auditd on CentOS 7':
      command     => "/bin/systemctl kill auditd",
      refreshonly => true,
      require => File['/etc/audit/rules.d/audit.rules'],
    } ~>
    exec { 'Read new configuration on CentOS 7':
      command => '/bin/systemctl daemon-reload',
      refreshonly => true,
      require => Exec['Kill auditd on CentOS 7'],
    } ~>
    exec { 'Start Auditd on Centos 7':
      command => '/bin/systemctl start auditd',
      refreshonly => true,
      require => Exec['Read new configuration on CentOS 7'],
    }
  }
  service { "auditd":
    enable     => true,
    ensure     => running,
    hasrestart => true,
  }
}
