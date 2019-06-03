#
# Installs and configured aide (Advanced Intrusion Detection Environment)
#
# CIS Centos Benchmarks 1.3.1, 1.3.2
class infra2_os::aide (
  $aide_enabled = hiera('aide_enabled', 'false'),
){

  require yum
  package {
    "aide":
      ensure => installed;
  }
  if $aide_enabled == "true" {
    # GuideSection 2.1.3.1.3
    # Build the initial aide database and install it for use
    exec {
      "Aide Init, 2.1.3.1.3":
        command => "/bin/nice -19 /usr/sbin/aide --init",
        creates => "/var/lib/aide/aide.db.new.gz",
        user    => "root",
        timeout => "-1",
        require => Package["aide"];

      "Install Aide Database, 2.1.3.1.3":
        command => "/bin/cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz",
        creates => "/var/lib/aide/aide.db.gz",
        user    => "root",
        require => [Package["aide"],Exec["Aide Init, 2.1.3.1.3"]];
    }
	
    # GuideSection 2.1.3.1.4
    # Set periodic integrity checks
    cron {
      "aide":
        ensure  => absent,
        command => "/usr/sbin/aide --check",
        user    => "root",
        hour    => 4,
        minute  => 05, 
        weekday => 6,
        require => Package["aide"];
    }
  }
}
