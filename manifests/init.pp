# == Class: pam_mount
#
# Configures and installs pam_mount
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  
#
# === Authors
#
# Jetroid <holtjet@gmail.com>
#
# === Copyright
#
# Copyright 2015 Jet Holt, unless otherwise noted.
#
class pam_mount (
  $ensure                = $pam_mount::params::ensure,
  $config                = $pam_mount::params::config,
  $pam_mount_package     = $pam_mount::params::pam_mount_package,
  $config_file           = $pam_mount::params::config_file,
  $extra_packages        = $pam_mount::params::extra_packages,
) inherits pam_mount::params {

validate_re($ensure, '^(present|absent)$',
  "${ensure} is not allowed for the 'ensure' parameter.
  Allowed values are 'present' and 'absent'.")

  validate_string(
    $pam_mount_package,
    $pam_mount_service,
  )

  validate_array(
    $extra_packages,
    $config,
  )

  anchor { 'pam_mount::begin': } ->
  class { '::pam_mount::install': } ->
  class { '::pam_mount::config': } ~>
#  class { '::pam_mount::service': } ->
  anchor { 'pam_mount::end': }

}

