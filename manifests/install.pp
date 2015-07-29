class pam_mount::install (
  $ensure             = $pam_mount::ensure,
  $pam_mount_package  = $pam_mount::pam_mount_package,
  $extra_packages     = $pam_mount::extra_packages,
) {

  package { $pam_mount_package:
    ensure => $ensure,
  }

  if $extra_packages {
    package { $extra_packages:
      ensure  => $ensure,
      require => Package[$pam_mount_package],
    }
  }
}
