
class { 'letsencrypt':
  agree_tos           => true,
  unsafe_registration => true,
}

letsencrypt::certificate { 'letstest.systemadmin.es':
<<<<<<< HEAD
=======
  webroot => '/var/lib/letsencrypt',
>>>>>>> 1b14ac929e22f9e05be8f612c1a154f9bfcab550
}
