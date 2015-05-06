
#
# Configures numad
#
class numad {

  require yum

  # Install numad IF this is a multi-socket server
  if ($physicalprocessorcount >= 2) {
    package { "libcgroup": ensure  => 'installed'} ->
	package { "numad": ensure  => 'installed'}     ->
	package { "numactl": ensure  => 'installed'}   ->
	package { "numatop": ensure  => 'installed'}   ->
    service { "cgconfig":
	  ensure     => running,
      enable     => true,
      hasrestart => true
    } ->
    service { "numad":
      ensure     => running,
      enable     => true,
      hasrestart => true
    }  
  }
}