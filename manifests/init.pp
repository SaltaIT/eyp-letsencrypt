class letsencrypt(
                    $manage_service        = true,
                    $manage_docker_service = true,
                    $service_ensure        = 'running',
                    $service_enable        = true,
                    $manage_package        = true,
                    $package_ensure        = 'installed',
                    $email                 = undef,
                    $agree_tos             = false,
                    $unsafe_registration   = false,
                    $rsakeysize            = '4096',
                    $autorenew             = true,
                    $webroot               = '/var/lib/letsencrypt',
                  ) inherits letsencrypt::params {
  if(!$agree_tos)
  {
    fail('You must agree TOS to be able to proceed (ie set agree_tos to true)')
  }

  if($email==undef)
  {
    if(!$unsafe_registration)
    {
      fail('You cannot proceed without setting an email unless you set unsafe_registration to true')
    }
  }

  class { '::letsencrypt::install': }
  -> class { '::letsencrypt::config': }
  ~> class { '::letsencrypt::service': }
  -> Class['::letsencrypt']

}
