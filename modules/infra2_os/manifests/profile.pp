#
# Configures /etc/profile
# Increases the default bash history size and formats bash history with dates.
class infra2_os::profile {

  file { '/etc/profile':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    content => template("$module_name/profile.erb"),

  }
}