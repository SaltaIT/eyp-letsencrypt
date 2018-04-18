
class { 'letsencrypt':
agree_tos             => true,
unsafe_registration   => true,
}

letsencrypt::certificate { 'letstest.systemadmin.es':
}
