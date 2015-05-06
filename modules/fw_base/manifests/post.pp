#
# class that sets up the base firewall
#

class fw_base::post {

  ### Drop everything else (mutally exclusive with the logging options below, so comment out appropriately)
#  firewall { "991 drop all other incoming requests":
#    chain  => 'INPUT',
#    proto  => 'all',
#    action => 'drop',
#  }
  
#  firewall { "992 drop all other outgoing requests":
#    chain  => 'OUTPUT',
#    proto  => 'all',
#    action => 'drop',
#  }

  ### Drop everything else and log it (mutally exclusive with the non-logging options above, so comment out appropriately)
   firewall { "991 jump all INPUT to the LOGGING chain":
     chain  => 'INPUT',
	 jump => 'LOGGING',
   }
  
   firewall { "992 jump all OUTPUT to the logging chain":
     chain  => 'OUTPUT',
	 jump => 'LOGGING',
   }
  
   firewall { "993 log what we are dropping":
     chain         => 'LOGGING',
	 #rate_limiting => '2/min', # Apparently we need a newer version of puppetlabs/firewall for this parameter
	 log_prefix    => 'IPTables-Dropped: ',
	 log_level     => '4',
	 jump          => 'LOG',
   }
  
   firewall { "994 drop everything else (after logging them)":
     chain  => 'LOGGING',
	 action => 'drop',
   }
}