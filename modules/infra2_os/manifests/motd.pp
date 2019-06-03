#
# Configures MOTD(Message of the Day)
#
class infra2_os::motd {

  file { 'copy over motd':
    path    => '/etc/motd',
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => '0644',
    content => template("$module_name/motd.erb"),
  }
  file { 'copy over issue.net':
    path    => '/etc/issue.net',
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => '0644',
    content => template("$module_name/motd.erb"),
  }
  file { 'removing OS information from /etc/issue':
    path    => '/etc/issue',
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => '0644',
    content => template("$module_name/motd.erb"),
  }
}