class letsencrypt::config inherits letsencrypt {

  file { '/etc/letsencrypt':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/letsencrypt/renew':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => File['/etc/letsencrypt'],
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
