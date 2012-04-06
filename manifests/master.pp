class puppet::master inherits puppet {
  
  file {
    "/etc/puppet/puppet.conf":
      content => template('puppet/main.erb', 'puppet/master.erb', 'puppet/agent.erb')
  }

  file {
    "/etc/puppet/fileserver.conf":
      source => "puppet:///modules/puppet/$name"
  }

  service {
    "puppet":
      ensure    => 'running',
      enable    => true,
      subscribe => File[ "/etc/puppet/puppet.conf" ],
      subscribe +> File[ "/etc/puppet/auth.conf" ],
  }

  service {
    "puppetmaster":
      ensure    => 'running',
      enable    => true,
      subscribe => File[ "/etc/puppet/puppet.conf" ],
      subscribe +> File[ "/etc/puppet/fileserver.conf" ],
      subscribe +> File[ "/etc/puppet/auth.conf" ],
  }

}
