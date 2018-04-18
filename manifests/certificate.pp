# cert = /etc/letsencrypt/live/example.com/cert.pem
# privkey = /etc/letsencrypt/live/example.com/privkey.pem
# chain = /etc/letsencrypt/live/example.com/chain.pem
# fullchain = /etc/letsencrypt/live/example.com/fullchain.pem
define letsencrypt::certificate (
                                  $domains = [ $name ],
                                  $renew_hook = undef,

                                ) {
  #
  $conf_file = inline_template('/etc/letsencrypt/renewal/<%= @domains.first %>.conf')
  $cert_dir = inline_template('/etc/letsencrypt/live/<%= @domains.first %>')

  #
  $cert_file = inline_template('/etc/letsencrypt/live/<%= @domains.first %>/cert.pem')
  $privkey_file = inline_template('/etc/letsencrypt/live/<%= @domains.first %>/privkey.pem')
  $chain_file = inline_template('/etc/letsencrypt/live/<%= @domains.first %>/chain.pem')
  $fullchain_file = inline_template('/etc/letsencrypt/live/<%= @domains.first %>/fullchain.pem')
  $archive_dir = inline_template('/etc/letsencrypt/archive/<%= @domains.first %>')

  file { $cert_dir:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Class['::letsencrypt'],
  }

  file { $conf_file:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/cert.erb")
  }
}
