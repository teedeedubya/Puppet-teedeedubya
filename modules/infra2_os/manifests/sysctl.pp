#
# Manages sysctl configuration file
#
class infra2_os::sysctl {

  file { '/etc/sysctl.conf':
    ensure  => present,
  	owner   => root,
  	group   => root,
  	mode    => '0644',
    content => template("$module_name/sysctl.conf.erb"),
    notify => Exec["refresh sysctl"],
  }
  file { '/etc/sysctl.d/ipv4.sysctl.conf':
    ensure  => present,
  	owner   => root,
  	group   => root,
  	mode    => '0644',
    content => template("$module_name/ipv4.sysctl.conf.erb"),
    notify => Exec["refresh sysctl"],
  }
  file { '/etc/sysctl.d/ipv6.sysctl.conf':
    ensure  => present,
  	owner   => root,
  	group   => root,
  	mode    => '0644',
    content => template("$module_name/ipv6.sysctl.conf.erb"),
    notify => Exec["refresh sysctl"],
  }
  file {'/etc/sysctl.d':
    ensure  => directory,
	owner   => root,
	group   => root,
	mode    => '0750',
  }
  file { '/opt/telligen/scripts/puppet/sysctl_apply.sh':
    ensure  => present,
   	owner   => root,
  	group   => root,
    mode    => '0750',
    content => template("$module_name/sysctl_apply.sh.erb"),
  }
exec { "refresh sysctl":
    command     => "/opt/telligen/scripts/puppet/sysctl_apply.sh",
    subscribe   => File['/etc/sysctl.conf'],
    refreshonly => true,
    user        => root,
    require     => [File['/opt/telligen/scripts/puppet/sysctl_apply.sh'],File['/etc/sysctl.d']]
  }
}
