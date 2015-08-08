#
# Configures default root password
#
# CIS CentOS security Benchmark 7.3

class infra2_os::root_user {
  user { 'root':
    ensure   => present,
	gid      => 0,
	shell    => '/bin/bash',
	password => 'root user hash goes here.',
  }
}