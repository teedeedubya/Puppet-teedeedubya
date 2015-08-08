#
# Manages sysctl configuration file
#
class infra2_os::sysctl {

  file { '/etc/sysctl.conf':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    content => template("$module_name/sysctl.conf.erb"),
  } 
exec { "refresh sysctl":
    command     => "/sbin/sysctl -p /etc/sysctl.conf",
    subscribe   => File['/etc/sysctl.conf'],
    refreshonly => true,
	user        => root,
  }  
}