class puppet::psql {

  class {
    "postgres":
      user => 'postgres',
  }

  package {
    "pg":
      ensure => 'installed',
      provider => 'gem',
  }

  postgres::user {
    "$puppet::params::dbuser":
      password => "$puppet::params::dbpassword",
  }

  postgres::database {
    "$puppet::params::dbname":
      owner   => "$puppet::params::dbuser",
      require => Postgres::User["$puppet::params::dbuser"],
  }

}
