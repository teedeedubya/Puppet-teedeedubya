# This module will create the transfer user and add the appropriate SSH key.

class infra2_os::gatransfer_user {
  # Quickbuild group
  group { 'gatransfer':
    ensure => present,
  } ->
  # Quickbuild user
  user { 'gatransfer':
    ensure     => present,
    managehome => true,
    groups     => 'gatransfer',
    home       => '/opt/gatransfer',
  }

  file { '/opt/gatransfer/.ssh':
    ensure => directory,
    owner  => gatransfer,
    group  => gatransfer,
    mode   => '0700',
  } ->
  ssh_authorized_key { 'gatransfer_key':
    ensure  => present,
    name    => gatransfer_key,
    key     => 'replace me',
    type    => rsa,
    user    => gatransfer,
    require => User['gatransfer'];
  }

  ssh::group_access { 'gatransfer_group_access':
    groups => ['gatransfer'],
  }
}
