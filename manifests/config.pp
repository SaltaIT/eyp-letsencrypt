class letsencrypt::config inherits letsencrypt {

  file { '/etc/letsencrypt':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}
