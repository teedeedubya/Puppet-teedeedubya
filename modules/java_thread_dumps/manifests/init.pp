
#
# Configures automated java thread dumps
#
class java_thread_dumps (
  $log_directory = hiera('java_thread_dumps_log_directory', "/var/log/thread_dumps/"),
  $retention_days = hiera('java_thread_dumps_retention_days',"7"),
  $dump_mode = hiera('java_thread_dumps_dump_mode',"744"),
  $process = hiera('java_thread_dumps_process',"tomcat-juli"),
  $user = hiera('java_trhead_dumps_user',"tomcat"),
) {
  require infra2_os
  
  file { '/opt/telligen/scripts/thread_dump.sh':
    ensure  => present,
	owner   => root,
	group   => $user,
	mode    => 0650,
    content => template("$module_name/thread_dump.sh.erb"),
  }
  cron { 'java thread dumps':
    command  => "/opt/telligen/scripts/thread_dump.sh",
    user     => $user,
    month    => '*',
	monthday => '*',
	hour     => '0',
	minute   => '*',
  }
}