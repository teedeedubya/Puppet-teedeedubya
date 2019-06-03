#
# Name: remove_floppy 
# Description Removes the floppy driver and rebuilds the initramfs using dracut.
# I get that this is not the cleanest thing on earth but getting those ghost 
# floppy errors pushed through via vmware is even worse.
# >>>   This module requires a reboot to relize these changes!!! <<<<<
#
class infra2_os::remove_floppy {
  if $operatingsystemmajrelease == '7' {
    file { "/lib/modules/${kernelrelease}/kernel/drivers/block/floppy.ko":
      ensure => absent,
    }
    exec { "rebuild initramfs":
      command => "/sbin/dracut -vf /boot/initramfs-${kernelrelease}.img ${kernelrelease}",
      subscribe => File["/lib/modules/${kernelrelease}/kernel/drivers/block/floppy.ko"],
      refreshonly => true,	
    }
  }
}