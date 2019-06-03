#
# class that sets up an nfs client
#

class infra2_os::nfs_client {
  $major_release = $::facts['os']['release']['major']
  require yum
  
  package { "nfs-utils": ensure => 'installed', } ->
  if $operatingsystemmajrelease == '6' {
  service { "rpcbind":
    ensure     => running,
    enable     => true,
    hasrestart => true
  } 
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
  } else {
    service { "rpcbind":
      ensure     => running,
      # enable     => true, # No longer required with CentOS 7
      hasrestart => true
  } 
    service { "rpc-statd":
	  ensure     => running,
	  # enable     => true, # Statically enabled process have a bug in CentOS 7
	  hasrestart  => true
	}
    service { "nfs-server":
      ensure     => running,
      enable     => true,
      hasrestart => true
    }
  }
}
