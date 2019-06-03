#
# Manages home directory permissions,ownership and removes stale user directories
#
# Addresses CIS CentOS Security Benchmarkes 9.2.7, 9.2.13
class infra2_os::home_directory_management(
  $deactivated_users = hiera('deactivated_users')
) {
  define delete_home_directories () {
    file { "/home/$name":
      ensure  => absent,
      force => true,
    }
  }
  infra2_os::home_directory_management::delete_home_directories {  $deactivated_users: }

  # CIS Benchmark 9.2.7
  exec { 'Check Home Directory Permissions':
	command     => "/bin/chmod --verbose 700 /home/*",
	user        => "root", 
	onlyif => "/bin/ls /home/ -Al | /bin/awk '{print \$1}' | /bin/grep -v total | /bin/grep -v drwx------.",
  } ->
  # CIS Benchmark 9.2.13
  file { '/opt/telligen/scripts/puppet/home_ownership_check.sh':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => '0700',
    content => template("$module_name/home_ownership_check.sh.erb"),
  } ->
    file { '/opt/telligen/scripts/puppet/home_ownership_enforcement.sh':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => '0700',
    content => template("$module_name/home_ownership_enforcement.sh.erb"),
  } ->
  exec { 'Check Home Directory Ownership and Group':
	command     => "/opt/telligen/scripts/puppet/home_ownership_enforcement.sh",
	user        => "root", 
	unless => "/opt/telligen/scripts/puppet/home_ownership_check.sh",
  } 
}