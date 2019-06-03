#
# Configures logwatch
#
class infra2_os::logwatch {
  package { 'logwatch': ensure => 'absent', }
  file { '/etc/logwatch/conf/logwatch.conf':
    ensure  => absent,
  }
  file { '/etc/cron.weekly/0logwatch':
    ensure  => absent,
  }
}
