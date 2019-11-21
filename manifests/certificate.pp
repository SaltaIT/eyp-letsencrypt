# cert = /etc/letsencrypt/live/example.com/cert.pem
# privkey = /etc/letsencrypt/live/example.com/privkey.pem
# chain = /etc/letsencrypt/live/example.com/chain.pem
# fullchain = /etc/letsencrypt/live/example.com/fullchain.pem


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

define letsencrypt::certificate (
                                  $webroot,
                                  $domains = [ $name ],
                                  $rsa_key_size = '4096',
                                ) {
  include ::letsencrypt

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  $conf_file = inline_template('/etc/letsencrypt/renewal/<%= @domains.first %>.conf')
  $cert_dir = inline_template('/etc/letsencrypt/live/<%= @domains.first %>')

  #
  $cert_file = inline_template('/etc/letsencrypt/live/<%= @domains.first %>/cert.pem')
  $privkey_file = inline_template('/etc/letsencrypt/live/<%= @domains.first %>/privkey.pem')
  $chain_file = inline_template('/etc/letsencrypt/live/<%= @domains.first %>/chain.pem')
  $fullchain_file = inline_template('/etc/letsencrypt/live/<%= @domains.first %>/fullchain.pem')
  $archive_dir = inline_template('/etc/letsencrypt/archive/<%= @domains.first %>')

  exec { "request certificate ${domains}":
    command => inline_template('certbot certonly --webroot-path <%= @webroot %> --rsa-key-size <%= @rsa_key_size %> --domains "<%= @domains.join(',') %>"'),
    creates => $cert_file,
    require => Class['::letsencrypt'],
  }

  # file { $cert_dir:
  #   ensure  => 'directory',
  #   owner   => 'root',
  #   group   => 'root',
  #   mode    => '0755',
  #   require => Class['::letsencrypt'],
  # }
  #
  # file { $conf_file:
  #   ensure  => 'present',
  #   owner   => 'root',
  #   group   => 'root',
  #   mode    => '0644',
  #   content => template("${module_name}/cert.erb")
  # }
}
