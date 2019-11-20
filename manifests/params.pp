class letsencrypt::params {

  $package_name='certbot'

  case $::osfamily
  {
    'redhat':
    {
      $include_epel = true
      $ppa_certbot = undef
      $service_name='certbot-renew.timer'
      case $::operatingsystemrelease
      {
        /^[5-7].*$/:
        {
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $include_epel = false
      $service_name='certbot.timer'
      case $::operatingsystem
      {
        'Ubuntu':
        {
          $ppa_certbot = 'ppa:certbot/certbot'
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
            }
            /^16.*$/:
            {
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian':
        {
          $ppa_certbot = undef
          case $::operatingsystemrelease
          {
            /^10.*$/:
            {
            }
            default: { fail("Unsupported Debian version! - ${::operatingsystemrelease}")  }
          }
        }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
