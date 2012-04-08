class puppet::master inherits puppet {
  
  file {
    "/etc/puppet/puppet.conf":
      content => template('puppet/main.erb', 'puppet/master.erb', 'puppet/agent.erb')
  }

  file {
    "/etc/puppet/fileserver.conf":
      source => "puppet:///modules/puppet/fileserver.conf"
  }

  service {
    "puppet":
      ensure    => 'running',
      enable    => true,
      subscribe => [
        File["/etc/puppet/puppet.conf"],
        File["/etc/puppet/auth.conf"],
      ],
  }

  service {
    "puppetmaster":
      ensure    => 'running',
      enable    => true,
      subscribe => [
        File["/etc/puppet/puppet.conf"],
        File["/etc/puppet/fileserver.conf"],
        File["/etc/puppet/auth.conf"],
      ],
  }

  if $puppet::params::storeconfigs {
    case $dbadapter {
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
