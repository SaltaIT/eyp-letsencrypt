# # Use this command if a webserver is already running with the webroot
# # at /var/www/html.
# certbot-auto certonly \
#   --agree-tos \
#   --non-interactive \
#   --text \
#   --rsa-key-size 4096 \
#   --email admin@example.com \
#   --webroot-path /var/www/html \
#   --domains "example.com, www.example.com"
#
# # Use this command if no webserver is running. Certbot will launch its
# # own webserver during the generation process.
# certbot-auto certonly \
#   --standalone \
#   --agree-tos \
#   --non-interactive \
#   --text \
#   --rsa-key-size 4096 \
#   --email admin@example.com \
#   --domains "example.com, www.example.com"

class letsencrypt(
                    $manage_package      = true,
                    $package_ensure      = 'installed',
                    $email               = undef,
                    $agree_tos           = false,
                    $unsafe_registration = false,
                    $rsakeysize          = '4096',
                    $autorenew           = true,
                  ) inherits letsencrypt::params {

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

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
