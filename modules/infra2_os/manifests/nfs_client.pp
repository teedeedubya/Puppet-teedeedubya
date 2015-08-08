#
# class that sets up an nfs client
#

class infra2_os::nfs_client {
  require yum
  
  package { "nfs-utils": ensure => 'installed', }
  ->
  service { "rpcbind":
    ensure     => running,
    enable     => true,
    hasrestart => true
  }
  ->
  service { "nfslock":
    ensure     => running,
    enable     => true,
    hasrestart => true
  }
  service { "nfs":
    ensure     => running,
    enable     => true,
    hasrestart => true
  }
}
