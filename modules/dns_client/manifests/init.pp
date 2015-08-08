#
# class that sets up the dns client
#

class dns_client (
  $enabled = "true",
  $domain = "example.com",
  $search_path = "example.com",
  $nameservers = ["1.1.1.1,"2.2.2.2" ,"3.3.3.3"]
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
