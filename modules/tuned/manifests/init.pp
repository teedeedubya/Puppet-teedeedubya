
#
# Configures tuned
#
class tuned ( $profile = undef )
{
  # Tuned must be installed from Yum
  require yum
  
  # Set the correct profile
  if ($profile == undef) {
	if ($is_virtual == 'true') {
	  $_profile = 'virtual-guest'
	}
	else {
	  $_profile = 'throughput-performance'
	}
  }
  else {
    $_profile = $profile
  }
  
  # Install and enable tuned
  package { "usermode": ensure  => 'installed'} ->
  package { "tuned": ensure  => 'installed'}     ->
  service { "tuned":
    ensure     => running,
    enable     => true,
    hasrestart => true
  }
  ->
  # Enable the proper profile
  exec { "tuned-adm profile ${_profile}":
    unless => "tuned-adm active | grep Current | grep ${_profile}",
    path => [ '/sbin', '/bin', '/usr/sbin' ],
    # No need to notify services, tuned-adm restarts them alone
  }

}