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
# TODO
    'Redhat': {
      $pam_mount_package   = 'pam_mount'
      $pam_mount_service   = 'pam_mount'
      $config_file    = '/etc/security/pam_mount.conf.xml'
      $extra_packages = [
      ]
    }
    'Debian': {
      $pam_mount_package   = 'libpam-mount'
      $pam_mount_service   = 'pam_mount'
      $config_file    = '/etc/security/pam_mount.conf.xml'
      $extra_packages = [
      ]
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }

}
