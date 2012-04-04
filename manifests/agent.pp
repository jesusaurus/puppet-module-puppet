class puppet::agent inherits puppet {
  
  file {
    "/etc/puppet/puppet.conf":
      content => template('puppet/main.erb', 'puppet/agent.erb')
  }

}
