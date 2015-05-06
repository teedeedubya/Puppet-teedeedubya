#
# Configures sshd
#
class ssh (
  $allowedGroupNames = [ 'linuxadmin' ], #array of group names that are allowed to ssh into this server
  $enabled = "true"
){
  if $enabled == "true" {
    require dns_client
  
    package { 'openssh-server': ensure => 'installed', } ->
    package { 'openssh-clients': ensure => 'installed', } ->
    file { '/etc/ssh/sshd_config':
      ensure  => present,
	  owner   => root,
	  group   => root,
	  mode    => 0600,
      notify  => Service[sshd],
      content => template("$module_name/sshd_config.erb"),
    } ~>
    service { "sshd":
      enable     => true,
      ensure     => running,
      hasrestart => true,
    }
  }
}