class puppet::psql {
  package {
    "postgresql-server":
      ensure => 'installed',
      ;
    "pg":
      ensure => 'installed',
      provider => 'gems',
      ;
  }
}
