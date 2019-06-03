class infra2_os::ctrlaltdel {
  $major_release = $::facts['os']['release']['major']
  if $major_release == '6' {
    file { 'copy standard control-alt-delete configuration file':
      path	=> '/etc/init/control-alt-delete.conf',
      ensure	=> present,
      owner	=> root,
      group	=> root,
      mode	=> '0644',
      content	=> template("infra2_os/control-alt-delete.conf.erb"),
    }
  }
  else {
    file { '/etc/systemd/system/ctrl-alt-del.target':
      ensure => 'link',
      target => '/dev/null',
    }
  }
}