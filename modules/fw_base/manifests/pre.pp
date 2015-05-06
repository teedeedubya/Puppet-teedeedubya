#
# class that sets up the base firewall
#

class fw_base::pre {

  # Setup the logging chain in case we need it
  firewallchain { 'LOGGING:filter:IPv4':
    ensure  => present,
  }

  # Default firewall rules
  firewall { '000 accept all incoming icmp':
    proto   => 'icmp',
    action  => 'accept',
  }
  
  firewall { '001 accept all outgoing icmp':
    chain   => 'OUTPUT',
	proto   => 'icmp',
    action  => 'accept',
  }
  
  firewall { '002 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',  
  }
  
  firewall { '003 accept all from lo interface':
    chain   => 'OUTPUT',
	proto   => 'all',
    outiface => 'lo',
    action  => 'accept',  
  }
  
  firewall { '004 accept related established rules on INPUT':
    chain   => 'INPUT',
	proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }
  
  firewall { '005 accept related established rules on OUTPUT':
    chain   => 'OUTPUT',
	proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }
}