#
# class that sets up standard CentOS packages
#

class infra2_os::std_packages {
    $major_release = $::facts['os']['release']['major']
  require yum

    # Some things to install
    if $major_release == '6' {
    package { 'man': ensure => 'installed', }
  }
  else {
    package { 'man-db': ensure => 'installed', }
  }
  package { 'mlocate': ensure => 'installed', }
  package { 'vim-enhanced': ensure => 'installed', }
  package { 'bind-utils': ensure => 'installed', }
  package { 'bc': ensure => 'installed', }
  package { 'man-pages': ensure => 'installed', }
  package { 'wget': ensure => 'installed', }
  package { 'curl': ensure => 'installed', }
  package { 'screen': ensure => 'installed', }
  package { 'dos2unix': ensure => 'installed', }
  package { 'traceroute': ensure => 'installed', }
  package { 'lsof': ensure => 'installed', }
  package { 'rsync': ensure => 'latest', }
  package { 'nmap': ensure => 'installed', }
  package { 'mailx': ensure => 'installed', }
  package { 'nmon': ensure => 'latest', }
  package { 'iotop': ensure => 'latest', }
  package { 'iftop': ensure => 'latest', }
  package { 'sysstat': ensure => 'latest', }
  package { 'finger': ensure => 'latest', } # hue hue hue
  package { 'star': ensure => 'installed', }
  package { 'openssl': ensure => 'latest', } # keep openssl up to date
  package { 'bash-completion': ensure => 'latest', }
  package {'yum-utils': ensure => 'latest'}
  package { 'unzip': ensure => 'installed', }
  package { 'lsscsi': ensure => 'installed', }
  
  # Some things that are unnecessary
  #package { "mdadm": ensure => 'absent', }
  #package { "device-mapper-multipath": ensure => 'absent', }
  #package { "device-mapper-multipath-libs": ensure => 'absent', }
}
