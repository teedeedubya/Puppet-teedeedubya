#
# Manages limits.d configuration file
#
class infra2_os::limitsd {

  file { '/etc/security/limits.d/telligen.conf':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => '0644',
    content => template("$module_name/telligen.conf.erb"),
  } 
}