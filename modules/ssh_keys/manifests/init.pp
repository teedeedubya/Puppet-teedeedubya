
#
# Configures ssh keys for passwordless access for authorized groups
#
class ssh_keys {
  file { "/opt/telligen":
    ensure => "directory",
	owner  => "root",
	group  => "root",
  }
  file { "/opt/telligen/scripts":
    ensure => "directory",
	owner  => "root",
    group  => "root",
  }
  file { '/opt/telligen/scripts/ssh_key_copy.sh':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0500,
    content => template("$module_name/ssh_key_copy.sh.erb"),
	require => [
	             File['/opt/telligen'],
			     File['/opt/telligen/scripts'],
			   ],
  }
    exec {'check ssh keys':
	command  => "/opt/telligen/scripts/ssh_key_copy.sh",
	user     => root,
  }
}