
#
# Configures MOTD(Message of the Day)
#
class motd {

  file { 'copy over motd':
    path    => '/etc/motd',
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    content => template("motd/motd.erb"),
  }
  file { 'copy over issue.net':
    path    => '/etc/issue.net',
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    content => template("motd/motd.erb"),
  }
}