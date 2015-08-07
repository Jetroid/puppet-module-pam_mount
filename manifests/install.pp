class pam_mount::install (
  $ensure             = $pam_mount::ensure,
  $config             = $pam_mount::config,
  $pam_mount_package  = $pam_mount::pam_mount_package,
  $config_file        = $pam_mount::config_file,
  $extra_packages     = $pam_mount::extra_packages,
) {

  if $::osfamily == 'RedHat' {
    yumrepo { "li.nux.ro":
      baseurl => "http://li.nux.ro/download/nux/dextop/el${::operatingsystemmajrelease}/${::architecture}/",
      descr => "nux RedHat Repository",
      enabled => 1,
      gpgcheck => 0
    }->
    package { 'pam_mount':
      source => $pam_mount_package,
      ensure => $ensure,
    }
  } elsif $::osfamily == 'Debian' {
    package { $pam_mount_package:
      ensure => $ensure,
    }
  }

  if $extra_packages {
    package { $extra_packages:
      ensure  => $ensure,
      require => Package[$pam_mount_package],
    }
  }
}
