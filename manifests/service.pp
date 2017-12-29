class letsencrypt::service inherits letsencrypt {

  #
  validate_bool($letsencrypt::manage_docker_service)
  validate_bool($letsencrypt::manage_service)
  validate_bool($letsencrypt::service_enable)

  validate_re($letsencrypt::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${letsencrypt::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $letsencrypt::manage_docker_service)
  {
    if($letsencrypt::manage_service)
    {
      service { $letsencrypt::params::service_name:
        ensure => $letsencrypt::service_ensure,
        enable => $letsencrypt::service_enable,
      }
    }
  }
}
