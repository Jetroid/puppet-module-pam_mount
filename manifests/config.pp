# See README.md for usage information
class pam_mount::config (
  $ensure                = $pam_mount::ensure,
  $config                = $pam_mount::config,
  $pam_mount_package     = $pam_mount::pam_mount_package,
  $config_file           = $pam_mount::config_file,
) {

  file { 'pam_mount.conf':
    ensure  => $ensure,
    path    => $config_file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('pam_mount/pam_mount.conf.xml.erb'),
  }

}
