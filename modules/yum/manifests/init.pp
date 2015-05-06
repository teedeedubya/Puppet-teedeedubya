
#
# Configures yum
#
class yum (
$version = "6.6",
) {
  require dns_client

  package { 'yum': ensure => 'installed', }
  package { 'yum-metadata-parser': ensure => 'installed', }
  package { 'yum-plugin-fastestmirror': ensure => 'installed', }
  package { 'yum-plugin-versionlock': ensure => 'installed', }	
  package { 'yum-cron': ensure => 'absent',}
  
 
  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-percona':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    content => template("$module_name/RPM-GPG-KEY-percona.erb"),
  }  

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    content => template("$module_name/RPM-GPG-KEY-CentOS-6.erb"),
  }  
 
  file { '/etc/yum.repos.d/CentOS-Base.repo':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    content => template("$module_name/CentOS-Base.repo.erb"),
  }
  
  file { '/etc/yum.repos.d/puppet.repo':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    content => template("$module_name/Puppet.repo.erb"),
  }
  
  file { '/etc/yum.repos.d/Epel.repo':
    ensure  => present,
	owner   => root,
	group   => root,
    mode    => 0644,
    content => template("$module_name/Epel.repo.erb"),
  }
  
  file { '/etc/yum.repos.d/Telligen.repo':
    ensure  => present,
	owner   => root,
	group   => root, 
	mode    => 0644,
    content => template("$module_name/Telligen.repo.erb"),
  }
  file { '/etc/yum.conf':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    content => template("$module_name/yum.conf.erb"),
  }
}