#
# Class to manage the boot loader for CentOS (GRUB)
# Addresses the following CIS CentOS Security benchmarks
# 1.5.1, 1.5.2, 1.5.4, 1.5.5

class infra2_os::boot_loader {
  file { "/boot/grub/grub.conf":
    ensure => present,  
  	owner  => root,
	group  => root,
    mode   => '0600',
  }
  file { 'require login for single user mode':
    path	=> '/etc/sysconfig/init',
	ensure	=> present,
	owner	=> root,
	group	=> root,
	mode	=> 0644,
	content	=> template("infra2_os/init.erb"),
  }
}