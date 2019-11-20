class letsencrypt::service inherits letsencrypt {

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
