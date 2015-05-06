#
# Configures default root password
#

class root_user {
  user { 'root':
    ensure   => present,
	shell    => '/bin/bash',
	password => 'copy and paste your root hash here',
  }
}