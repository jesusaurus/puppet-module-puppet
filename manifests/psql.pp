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

  exec {
    "Grant CREATE to puppet user on puppet database":
      command     => "/usr/bin/psql -h $puppet::params::dbserver --username=postgres postgres -c \"grant create on database $puppet::params::dbname to $puppet::params::dbuser\"",
      environment => "PGPASSWORD=$puppet::params::dbpassword",
      require     => [
        Postgres::User[ "$puppet::params::dbuser" ],
        Postgres::Database[ "$puppet::params::dbname" ],
      ],
  }

}
