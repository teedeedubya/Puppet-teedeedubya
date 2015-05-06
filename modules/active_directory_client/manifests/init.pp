#
# This class is responsible for joining a 
# centOS box into AD and setting up basic authentication/authorization
#
class active_directory_client ( 
  $ldap_default_authtok = hiera('ldap_default_authtok'),
  $enabled = "true"
){
  if $enabled == "true" {
    require dns_client
    require ntp_client
    require yum
  
    File {
      owner => 'root',
      group => 'root',
      mode  => '600',
    }
 
    # push ldap.conf
    package { 'openldap-clients': ensure => 'installed', }
  
    file { '/etc/openldap/ldap.conf':
      ensure => 'present',
      source => "puppet:///modules/$module_name/ldap.conf",
      mode   => "644",
    }
  
   # kerberos
    package { 'krb5-workstation': ensure => 'installed', }
  
    file { '/etc/krb5.conf':
      ensure  => present,
      content => template("$module_name/krb5.conf.erb"),
	  mode  => '644',
    }
  
    file { '/root/.join_ad.sh': ensure => 'absent', }

    # this is required for oddjob (which makes users' home directory on demand)
    package { 'dbus': 
      ensure => 'installed'
    } 
  
    service { 'messagebus':
      ensure => running,
      enable => true,
    }

    #used to create home directories upon login
    package { 'oddjob-mkhomedir': ensure => 'installed', }
  
    service { 'oddjobd':
      ensure  => running,
      enable  => true,
      require => Service['messagebus'],
    }
  
    file { '/etc/pam.d/password-auth-ac':
      ensure => 'present',
      source => "puppet:///modules/$module_name/password-auth",
      mode   => "644",
    }

    file { '/etc/pam.d/system-auth-ac':
      ensure => 'present',
      source => "puppet:///modules/$module_name/password-auth",
      mode   => "644",
    }

    #SSSD
    package { 'sssd': ensure => 'installed', }
  
    file {'/etc/sssd/sssd.conf':
      ensure  => present,
      content => template("$module_name/sssd.conf.erb"),
      mode   => "600", #this needs to be root only
    } 
  
    file { '/etc/nsswitch.conf':
      ensure => 'present',
      source => "puppet:///modules/$module_name/nsswitch.conf",
      mode  => '644',
    }
  
    file { '/etc/openldap/certs/telligen-CA.crt':
      ensure => 'present',
      source => "puppet:///modules/$module_name/telligen-CA.crt",
      mode  => '644',
    }
  
    service { "sssd":
      enable     => true,
      ensure     => running,
      hasrestart => true,
	  subscribe  => File['/etc/sssd/sssd.conf'],
    } 
  }
}
