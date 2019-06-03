#
# Configures default root password
#
# CIS CentOS security Benchmark 7.3

class infra2_os::root_user(
  $root_user_hash = hiera('root_user_hash'),

) {
  user { 'root':
    ensure   => present,
	gid      => 0,
	shell    => '/bin/bash',
	password => $root_user_hash,
  }
  file { '/root/.bashrc':
    ensure => present,
	owner  => root,
	group  => root,
	mode   => '644',
	content => template("$module_name/root_bashrc.erb"),
  }
}