#
# class that sets up an nfs client
#

class nfs_client {
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
}
