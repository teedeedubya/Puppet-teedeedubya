# This module will create the ansible user and add the appropriate SSH key.

class infra2_os::ansible_user (
  $ansible_ssh_enabled = hiera('ssh_enabled','true')
){
  # ansible group
  group { "ansible":
    ensure => present,
    gid    => 1292,
  } ->
  # ansible user
  user { "ansible":
    ensure     => present,
    managehome => true,
    uid        => 1292,
    gid        => 1292,
    home       => "/opt/telligen/ansible",
  } ->
  file { '/opt/telligen/ansible':
    ensure => directory,
    mode   => '700',
    owner => ansible,
    group => ansible,
  } ->
  
  # allow ansible root privs 
   file { '/etc/sudoers.d/ansible':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template("$module_name/ansible.sudoers.erb"),
  } ->
  
  file { '/opt/telligen/ansible/.ssh':
    ensure => directory,
    owner  => ansible,
    group  => ansible,
    mode   => '700',
  } ->
  ssh_authorized_key { 'ansible_key':
    name    => ansible_key,
    ensure  => present,
    key     => 'replace me',
    type    => rsa,
    user    => ansible,
    require => User['ansible'];
  }
  if $ansible_ssh_enabled == 'true' {
    ssh::group_access { 'grant ansible group access for automation':
      groups	=> [
        "ansible"
      ],
      module_identifier => 'ansible'
    }
  } 
}
  
