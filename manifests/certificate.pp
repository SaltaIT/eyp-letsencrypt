# cert = /etc/letsencrypt/live/example.com/cert.pem
# privkey = /etc/letsencrypt/live/example.com/privkey.pem
# chain = /etc/letsencrypt/live/example.com/chain.pem
# fullchain = /etc/letsencrypt/live/example.com/fullchain.pem
define letsencrypt::certificate (
                                  $domains = [ $name ],
                                ) {
  #
  $cert_file = inline_template('/etc/letsencrypt/live/<%= @domains.first %>/cert.pem')
  $conf_file = inline_template('/etc/letsencrypt/renew/<%= @domains.first %>.conf')


  file { $conf_file:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/cert.erb")
  }
}
