#
# Configures VM Tools
#
class infra2_os::vmtools {

  require yum

  # Remove proprietary VMware Tools, if they are already installed,
  # and install open-vm-tools RPM from the EPEL repository

  if  $is_virtual {
    if $ec2_metadata == undef {
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
}
