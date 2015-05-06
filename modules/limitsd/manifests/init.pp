#
# Manages limits.d configuration file
#
class limitsd {

  file { '/etc/security/limits.d/custom.conf':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    content => template("$module_name/custom.conf.erb"),
  } 

}