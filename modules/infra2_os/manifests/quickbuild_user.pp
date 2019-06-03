# This module will create the quickbuild user and add the appropriate SSH key.  You'll still need to include the quickbuild user in the authorized
# SSH users within the manifest.


class infra2_os::quickbuild_user {
  # Quickbuild group
  group { "quickbuild":
    ensure => present,
    gid    => 989,
  } ->
  # Quickbuild user
  user { "quickbuild":
    ensure     => present,
    managehome => true,
    uid        => 600,
    gid        => 989,
    home       => "/opt/quickbuild",
  }
  
  # allow quickbuild user to run a puppet agent --test to make sure that the box's configuration is up to snuff
   file { '/etc/sudoers.d/quickbuild_puppet':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template("$module_name/quickbuild_puppet.sudoers.erb"),
  }
  
  file { '/opt/quickbuild/.ssh':
    ensure => directory,
    owner  => quickbuild,
    group  => quickbuild,
    mode   => '700',
  } ->
  ssh_authorized_key { 'quickbuild_key':
    name    => quickbuild_key,
    ensure  => present,
    key     => 'replace me',
    type    => rsa,
    user    => quickbuild,
    require => User['quickbuild'];
  }
  
  
}
  
