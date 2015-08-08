#
# Configures logwatch
#
class infra2_os::logwatch {
  require dns_client
  require yum

  package { 'logwatch': ensure => 'installed', } ->
  file { '/etc/logwatch/conf/logwatch.conf':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    content => template("$module_name/logwatch.conf.erb"),
  } ->
  exec { "set logwatch to run weekly instead of daily":
    command => '/bin/mv /etc/cron.daily/0logwatch /etc/cron.weekly',
    creates => '/etc/cron.weekly/0logwatch',
  }
}