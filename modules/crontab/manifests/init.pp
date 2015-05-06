#
# Configures default system crontab
#

class crontab {
  if ($productname == 'VMware Virtual Platform'){
    file {'/etc/cron.d/raid-check':
      ensure => 'absent',
	}  
  }
}