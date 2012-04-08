class puppet::sqlite {

  # This is a stub class,
  # if you use sqlite then please make this work

  package {
    "sqlite3":
      ensure => 'installed',
      ;
    "libsqlite3-ruby":
      ensure => 'installed',
      ;
  }
}
