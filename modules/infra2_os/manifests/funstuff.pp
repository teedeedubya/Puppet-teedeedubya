class infra2_os::funstuff {

  file { '/etc/profile.d/please.sh':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("$module_name/please.sh.erb"),
  }
  file { '/etc/profile.d/wam.sh':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("$module_name/wam.sh.erb"),
  }
}
