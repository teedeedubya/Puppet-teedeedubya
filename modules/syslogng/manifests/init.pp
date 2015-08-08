
#
# Configures syslog-ng
#
class syslogng (
  $enabled = "true",
  $transport_logs = "false", 
  $transport_protocol = "udp", #valid options are tcp or udp
  $transport_destination = "127.0.0.1", #default is not a valid option
  $transport_port = "22551"
  ) {
  if $enabled == "true" {
    require dns_client
    require yum
  
    package { 'syslog-ng': ensure => 'installed', } ->
    package { 'syslog-ng-libdbi': ensure => 'installed', } ->
    service { "rsyslog":
      enable     => false,
      ensure     => stopped,
    } ->
	package { 'rsyslog': ensure => 'absent', } ->
    file { '/etc/syslog-ng/syslog-ng.conf':
      ensure  => present,
	  owner   => root,
	  group   => root, 
      mode    => 0644,
      notify  => Service[syslog-ng],
      content => template("syslogng/syslog-ng.conf.erb"),
    } ~>
    service { "syslog-ng":
      enable     => true,
      ensure     => running,
      hasrestart => true,
    }
  }
}
