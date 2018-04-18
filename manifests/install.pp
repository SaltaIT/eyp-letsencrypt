class letsencrypt::install inherits letsencrypt {

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if($letsencrypt::manage_package)
  {
    if($letsencrypt::params::include_epel)
    {
      include ::epel

      Package[$letsencrypt::params::package_name] {
        require => Class['::epel'],
      }
    }

    if($letsencrypt::params::ppa_certbot!=undef)
    {
      apt::ppa { $letsencrypt::params::ppa_certbot:
        ensure => 'present',
      }

      Package[$letsencrypt::params::package_name] {
        require => Apt::Ppa[$letsencrypt::params::ppa_certbot],
      }
    }

    package { $letsencrypt::params::package_name:
      ensure => $letsencrypt::package_ensure,
    }

    exec { 'init letsencrypt':
      command => "certbot -h",
      creates => '/etc/letsencrypt/renewal-hooks',
      require => Package[$letsencrypt::params::package_name],
    }
  }

}
