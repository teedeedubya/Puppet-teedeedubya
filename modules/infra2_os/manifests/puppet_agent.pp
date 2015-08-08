#
# class manages puppet agent
#

class infra2_os::puppet_agent (
  $run_interval = hiera('puppet_run_interval'),
){
  if $hostname != 'dmnocppup01'{
    require yum
    require dns_client
    package { "puppet": ensure  => 'latest'}     ->
    file { "/etc/puppet/puppet.conf":
      ensure => present,  
  	  owner  => root,
	  group  => root,
      mode   => '0644',
	  notify  => Service[puppet],
	  content => template("$module_name/puppet.conf.erb"),
    } ->
    service { "puppet":
      enable     => true,
      ensure     => running,
      hasrestart => true,
    }
  }
}