class letsencrypt::install inherits letsencrypt {

  if($letsencrypt::manage_package)
  {
    if($fping::params::include_epel)
    {
      include ::epel

      Package[$fping::params::package_name] {
        require => Class['::epel'],
      }
    }

    package { $letsencrypt::params::package_name:
      ensure => $letsencrypt::package_ensure,
    }
  }

}
