
#
# Configures sudo
#
class sudo (
  $enabled = "true"
) {
  if $enabled == "true" {
    require yum

    package { 'sudo': ensure => 'installed', } ->
    file { '/etc/sudoers':
      ensure  => present,
      owner   => root,
	  group   => root,
	  mode    => 0440,
      content => template("$module_name/sudoers.erb"),
	}
  }
}