class puppet::master (
  $agent_mode     = 'none',
  $master_service = 'puppetmaster',
) inherits puppet {

  # Fail hard and fast
  if ! ($agent_mode in [ 'none', 'cron', 'service' ]) {
    fail ("Unknown mode for agent: $agent_mode")
  }

  # We use hiera
  include puppet::hiera


  # Configuration files
  file {
    "/etc/puppet/puppet.conf":
      content => template('puppet/main.erb', 'puppet/master.erb', 'puppet/agent.erb'),
      require => $puppet::params::storeconfigs ? {
        true    => $puppet::params::dbadapter ? {
          'postgresql' => Postgres::Database[ "$puppet::params::dbname" ],
          default      => [],
        }
      }
  }

  file {
    "/etc/puppet/fileserver.conf":
      source => "puppet:///modules/puppet/fileserver.conf",
  }


  # Local puppet agent

  case $agent_mode {
    'service': {
      $agent_service = true
      $agent_cron    = absent
    }

    'cron': {
      $agent_service = false
      $agent_cron    = present
    }

    'none': {
      $agent_service = false
      $agent_cron    = absent
    }

  }

  service { "puppet":
    ensure    => $agent_service,
    enable    => $agent_service,
    subscribe => [
      File[ "/etc/puppet/puppet.conf" ],
    ],
  }

  cron { "puppet":
    ensure  => $agent_cron,
    command => 'puppet agent --onetime --splay 60 --no-daemonize',
    minute  => [ fqdn_rand(30), fqdn_rand(30)+29 ],
  }


  # Puppet master

  service { "$master_service":
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
