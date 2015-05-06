#
# class that sets up standard CentOS packages
#

class std_packages {
    require yum

    # Some things to install
    package { "mlocate": ensure => 'installed', }
	package { "vim-enhanced": ensure => 'installed', }
	package { "bind-utils": ensure => 'installed', }
	package { "man": ensure => 'installed', }
	package { "man-pages": ensure => 'installed', }
	package { "telnet": ensure => 'installed', }
	package { "wget": ensure => 'installed', }
	package { "curl": ensure => 'installed', }
	package { "screen": ensure => 'installed', }
	package { "dos2unix": ensure => 'installed', }
	package { "traceroute": ensure => 'installed', }
	package { "lsof": ensure => 'installed', }
	package { "rsync": ensure => 'installed', }
	package { "nmap": ensure => 'installed', }
	package { "mailx": ensure => 'installed', }
	package { "nmon": ensure => 'latest', }
}
