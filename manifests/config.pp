class letsencrypt::config inherits letsencrypt {

  file { '/etc/letsencrypt':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  # /etc/letsencrypt/cli.ini
  file { '/etc/letsencrypt/cli.ini':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/cli.erb"),
    require => File['/etc/letsencrypt'],
  }
}
