#
# Manages limits.d configuration file
#
class infra2_os::telligen {
  file { "/opt/telligen":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode => "0755",
  }
  file { "/opt/telligen/scripts":
    ensure => "directory",
    owner  => "root",
    group  => "root",
    mode => "0755",
  }
  file { '/opt/telligen/scripts/service_shutdown.sh':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => '0750',
    content => template("$module_name/service_shutdown.sh.erb"),
  } 
}