class infra2_os {

  include infra2_os::auditd
  include infra2_os::boot_loader
  include infra2_os::crontab
  include infra2_os::ctrlaltdel
  include infra2_os::disable_avahi
  include infra2_os::limitsd
  include infra2_os::logwatch
  include infra2_os::motd
  include infra2_os::numad
  include infra2_os::nfs_client
  include infra2_os::profile
  include infra2_os::puppet_agent
  include infra2_os::root_user
  include infra2_os::selinux
  include infra2_os::sysctl
  include infra2_os::std_packages
  include infra2_os::vmtools
}