# Default parameters
class pam_mount::params {

  $ensure = 'present'
  $config = [
    ['debug',        {'enable'   => '0'}],
    ['mntoptions',   {'allow'    => 'nosuid,nodev,loop,encryption,fsck,nonempty,allow_root,allow_other'}],
    ['mntoptions',   {'require'  => 'nosuid,nodev'}],
    ['logout',       {'wait'     => '0',
                      'hup'      => '0',
                      'term'     => '0',
                      'kill'     => '0',}],
    ['mkmountpoint', {'enable'   => '1',
                      'remove'    => 'true',}],
  ]  
    
  case $::osfamily {
    'Redhat': {
      case $::operatingsystemmajrelease {
        '6': {
          $pam_mount_package = "pam_mount-2.5-2.el6.nux.${::architecture}.rpm"
        }
        '7': {
          $pam_mount_package = "pam_mount-2.14-3.el7.nux.${::architecture}.rpm"
        }
      }
      $config_file    = '/etc/security/pam_mount.conf.xml'
      $extra_packages = [
      ]
    }
    'Debian': {
      $pam_mount_package   = 'libpam-mount'
      $config_file    = '/etc/security/pam_mount.conf.xml'
      $extra_packages = [
      ]
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }

}
