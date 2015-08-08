#
# class that sets up the base firewall
#

class fw_base (
  $enabled = "true",
) {
  if $enabled == "true" {
    stage { 'fw_pre':  before  => Stage['main']; }
    stage { 'fw_post': require => Stage['main']; }
 
     class { 'firewall':
       stage => 'fw_pre',
     }
 
     class { 'fw_base::pre':
       stage => 'fw_pre',
     }
 
     class { 'fw_base::post':
       stage => 'fw_post',
     }
 
    resources { "firewall":
       purge => true
    }

    ### Allow all traffic on the SAN NIC
    firewall { '98 accept all to eth1 interface':   proto => 'all', iniface => 'eth1', action => 'accept' }
    firewall { '99 accept all from eth1 interface': proto => 'all', chain => 'OUTPUT', outiface => 'eth1', action => 'accept' }
  
    ### Incoming rules  
    firewall { '100 allow SSH in':          port => '22', proto => tcp, action => accept }
    firewall { '101 allow SNMP in':         port => '161', proto => udp, action => accept }
    firewall { '102 allow Zabbix in':       port => '10050', proto => tcp, action => accept }
    firewall { '103 allow GridMonitor OEM in':       port => '3872', proto => tcp, action => accept }
	

    ### OUTPUT rules
    firewall { '300 allow Puppet out':         chain => 'OUTPUT', port => '8140', proto => tcp, action => accept }
    firewall { '301 allow DNS udp out':        chain => 'OUTPUT', port => '53', proto => udp, action => accept }
    firewall { '302 allow DNS tcp out':        chain => 'OUTPUT', port => '53', proto => tcp, action => accept }
    firewall { '303 allow HTTP out':           chain => 'OUTPUT', port => '80', proto => tcp, action => accept }
    firewall { '304 allow HTTPS out':          chain => 'OUTPUT', port => '443', proto => tcp, action => accept }
    firewall { '305 allow SMTP out':           chain => 'OUTPUT', port => '25', proto => tcp, action => accept }
    firewall { '306 allow SSH out':            chain => 'OUTPUT', port => '22', proto => tcp, action => accept }
    firewall { '307 allow SNMPTRAP out':       chain => 'OUTPUT', port => '162', proto  => udp, action => accept }
    firewall { '308 allow LDAP out':           chain => 'OUTPUT', port => '389', proto => tcp, action => accept }
    firewall { '309 allow SYSLOG out':         chain => 'OUTPUT', port => '514', proto => tcp, action => accept }
    firewall { '310 allow NTP out':            chain => 'OUTPUT', port => '123', proto => udp, action => accept }
    firewall { '311 allow Kerberos out':       chain => 'OUTPUT', port => '88', proto => udp, action => accept }
    firewall { '312 allow Kerberos out':       chain => 'OUTPUT', port => '88', proto => tcp, action => accept }
    firewall { '313 allow Kerberos Admin out': chain => 'OUTPUT', port => '749', proto => udp, action => accept }
    firewall { '315 allow Zabbix out':         chain => 'OUTPUT', port => '10051', proto => tcp, action => accept }
    firewall { '316 allow Commvault out':      chain => 'OUTPUT', port => '8600-8610', proto => tcp, action => accept }
	firewall { '317 allow GridMonitor OEM out':      chain => 'OUTPUT', port => '4903', proto => tcp, action => accept }

  } 
}