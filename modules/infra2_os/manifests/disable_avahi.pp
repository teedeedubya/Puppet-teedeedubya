#
# disable_avahi
#
# CIS CentOS Benchmark
# section 3.3 "disable avahi Server"
class infra2_os::disable_avahi {
  service {
    "avahi-daemon":
    ensure  => false,
    enable  => false,
  }
}