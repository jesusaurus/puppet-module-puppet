class puppet::master inherits puppet {

  include puppet::hiera

  file {
    "/etc/puppet/puppet.conf":
      content => template('puppet/main.erb', 'puppet/master.erb', 'puppet/agent.erb'),
      require => $puppet::params::storeconfigs ? {
        true    => $puppet::params::dbadapter ? {
          'postgresql' => Postgres::Database[ "$puppet::params::dbname" ],
        }
      }
  }

  file {
    "/etc/puppet/fileserver.conf":
      source => "puppet:///modules/puppet/fileserver.conf",
  }

  service {
    "puppet":
      ensure    => 'running',
      enable    => true,
      subscribe => [
        File["/etc/puppet/puppet.conf"],
      ],
  }

  service {
    "puppetmaster":
      ensure    => 'running',
      enable    => true,
      subscribe => [
        File["/etc/puppet/puppet.conf"],
        File["/etc/puppet/fileserver.conf"],
      ],
  }

  if $puppet::params::storeconfigs {
    case $puppet::params::dbadapter {
      'puppetdb': {
        include puppet::puppetdb
      }
      'sqlite3': {
        include puppet::sqlite
      }
      'postgresql': {
        include puppet::psql
      }
      'mysql': {
        include puppet::mysql
      }
      default: {
        err("Bad storeconfig backend specified: $dbadapter")
      }
    }
  }

}
