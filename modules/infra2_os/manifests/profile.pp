#
# Configures /etc/profile
# Increases the default bash history size and formats bash history with dates.
class infra2_os::profile (
  $environment = $::environment,
){
  $environment_array = split($environment,'_')
  $environment_contract_code = $environment_array[0]
  $environment_tier = $environment_array[-1]

  file { '/etc/profile':
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => '0644',
    content => template("$module_name/profile.erb"),
  }
  file { '/etc/bashrc':
    ensure => present,
	owner  => root,
	group  => root,
	mode   => '644',
	content => template("$module_name/bashrc.erb"),
  }
  file { '/etc/profile.d/autologout.sh':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0744',
    content => template("$module_name/autologout.sh.erb"),
  }
}