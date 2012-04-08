class puppet::psql {

  class {
    "postgres":
      user => 'postgres',
  }

  package {
    "pg":
      ensure => 'installed',
      provider => 'gems',
  }

  postgres::user {
    "puppet":
      password => 'password',
  }

  postgres::database {
    "puppet":
      owner   => 'puppet',
      require => Postgres::User["puppet"],
  }

}
