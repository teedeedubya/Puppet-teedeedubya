#
# Configures numad
#
class infra2_os::numad {

  require yum

  # Install numad IF this is a multi-socket server
  if (($physicalprocessorcount + 0) >= 2) {
    package { "libcgroup": ensure  => 'installed'} ->
	package { "numad": ensure  => 'installed'}     ->
	package { "numactl": ensure  => 'installed'}  
    if $major_release == '6' {
      package { "numatop": ensure  => 'installed'} 
      service { "cgconfig":
        ensure     => running,
        enable     => true,
        hasrestart => true
      }
	}
    service { "numad":
      ensure     => running,
      enable     => true,
      hasrestart => true
    }  
  }
}