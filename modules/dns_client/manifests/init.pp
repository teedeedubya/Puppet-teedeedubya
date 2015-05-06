#
# class that sets up the dns client
#

class dns_client (
$enabled = 'true'
){

  if $enabled == "true" {
    file { "/etc/resolv.conf":
      ensure => present,  
  	  owner  => root,
	  group  => root,
      mode   => '0644',
	  content => template("$module_name/resolv.conf.erb"),
    }
  }
}
