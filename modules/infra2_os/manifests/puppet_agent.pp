#
#
#
# class manages puppet agent
#

class infra2_os::puppet_agent (
  $run_interval = hiera('puppet_run_interval'),
  $masterhost = hiera('puppet_master_host'),
  $version = hiera('puppet_version'),
){
  require yum
  require dns_client

if $fqdn != $masterhost {
  if $version == 3 {
    $confpath = '/etc/puppet/puppet.conf'
    $pkgstatus = 'present'
    $puppetname = 'puppet'
	$pkgname = 'puppet'
  }
  elsif $version == 4 {
    $confpath = '/etc/puppetlabs/puppet/puppet.conf'
    $pkgstatus = 'latest'
    $puppetname = 'puppetlabs'
    $pkgname = 'puppet-agent'
	file { '/etc/puppet':
      ensure  => absent,
      force   => true,
    }
  } else {
    notify {"No puppet_version defined in hiera.  Expecting 3 or 4!":
      loglevel => err,
    }
  }
    package { $pkgname: ensure  => $pkgstatus}     ->
    file { 'puppet.conf':
      path  => $confpath,
      ensure => present,
      owner  => root,
      group  => root,
      mode   => '0644',
      notify  => Service[puppet],
      content => template("$module_name/puppet.conf.erb"),
      }
    service { "puppet":
      enable     => true,
      ensure     => running,
      hasrestart => true,
    }
	
  }
 }
