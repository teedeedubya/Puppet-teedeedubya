# This module will create the transferuser user and add the appropriate SSH key.  You'll still need to include the transferuser user in the authorized
# SSH users within the manifest.


class infra2_os::transferuser {
  # Quickbuild group
  group { "transferuser":
    ensure => present,
    gid    => 30000,
  } ->
  # Quickbuild user
  user { "transferuser":
    ensure     => present,
    managehome => true,
    uid        => 30000,
    gid        => 30000,
    home       => "/opt/transferuser",
	shell      => "/bin/bash",
  }

  file { '/opt/transferuser':
    ensure => directory,
    owner  => transferuser,
    group  => transferuser,
    mode   => '700',
  } ->
  file { '/opt/transferuser/.ssh':
    ensure => directory,
    owner  => transferuser,
    group  => transferuser,
    mode   => '700',
  } ->
  ssh_authorized_key { 'transferuser_key':
    name    => transferuser_key,
    ensure  => present,
    key     => 'replace me',
    type    => rsa,
    user    => transferuser,
    require => User['transferuser'];
  }
  

  ssh::group_access { 'transferuser_group_access':
    groups => ['transferuser'],
  }

}
