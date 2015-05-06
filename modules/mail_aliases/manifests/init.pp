#
# class that sets up a mail aliases
#

class mail_aliases {

  mailalias { root:
    ensure => present,
    name => root,
    recipient => 'yoursharedsystemsmailbox@example.com',
	target => "/etc/aliases",
    notify => Exec['newaliases'],
  }

  exec {'newaliases':
	command  => "/usr/bin/newaliases",
	user     => root,
	refreshonly => true,
  }
}
