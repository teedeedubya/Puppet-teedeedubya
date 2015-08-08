#
# Installs selinux and manages /etc/selinux/config
#
class infra2_os::selinux {
  require yum

  package { 'selinux-policy-targeted': ensure => 'installed', } ->
  file { 'copy standard selinux configuration file':
    path    => '/etc/selinux/config',
    ensure  => present,
	owner   => root,
	group   => root,
	mode    => 0644,
    content => template("$module_name/config.erb"),
  }
}