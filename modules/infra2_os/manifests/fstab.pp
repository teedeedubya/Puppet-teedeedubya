#
# manages the fstab to enforce compliance and proper mounts on all I2.0 infra
#
# CIS Benchmarks 1.1.14, 1.1.15, 1.1.16
class infra2_os::fstab {
  mount { '/dev/shm':
    device => 'tmpfs',
    ensure => mounted,
    atboot => true,
    fstype => 'tmpfs',
    options => 'defaults,nodev,nosuid,noexec',
    remounts => 'true',
  }
}