class puppet::sqlite {
  package {
    "sqlite3":
      ensure => 'installed',
      ;
    "libsqlite3-ruby":
      ensure => 'installed',
      ;
  }
}
