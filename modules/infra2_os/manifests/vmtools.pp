#
# Configures VM Tools
#
class infra2_os::vmtools {

  require yum

  # Remove proprietary VMware Tools, if they are already installed,
  # and install open-vm-tools RPM from the EPEL repository
  if ($virtual == 'vmware'){
    exec {"remove-vmware-tools":
      command => '/usr/bin/vmware-uninstall-tools.pl',
      onlyif  => '/usr/bin/test -e /usr/bin/vmware-uninstall-tools.pl',
	  timeout => 600,
    }
    ->
    package { "open-vm-tools":
	  ensure  => 'installed',
	}
    ->
    service { "vmtoolsd":
      ensure     => running,
      enable     => true,
      hasrestart => true
    }  
  }
}