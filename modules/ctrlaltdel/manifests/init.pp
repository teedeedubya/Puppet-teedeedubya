class ctrlaltdel {
  require yum

  file { 'copy standard control-alt-delete configuration file':
    path	=> '/etc/init/control-alt-delete.conf',
	ensure	=> present,
	owner	=> root,
	group	=> root,
	mode	=> 0644,
	content	=> template("ctrlaltdel/control-alt-delete.conf.erb"),
  }
}