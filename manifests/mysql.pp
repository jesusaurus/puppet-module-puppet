class puppet::mysql {
  package {
    'mysql':
      ensure => 'installed',
      ;
  }
}
