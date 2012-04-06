class puppet::agent inherits puppet {
  
  file {
    "/etc/puppet/puppet.conf":
      content => template('puppet/main.erb', 'puppet/agent.erb')
  }

  service {
    "puppet":
      ensure    => 'running',
      enable    => true,
      subscribe => File[ "/etc/puppet/puppet.conf" ],
      subscribe +> File[ "/etc/puppet/auth.conf" ],
  }

}
