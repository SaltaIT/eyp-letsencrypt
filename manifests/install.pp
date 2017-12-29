class letsencrypt::install inherits letsencrypt {

  if($letsencrypt::manage_package)
  {
    package { $letsencrypt::params::package_name:
      ensure => $letsencrypt::package_ensure,
    }
  }

}
