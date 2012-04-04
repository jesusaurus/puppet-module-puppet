class puppet::master inherits puppet {
  
  file {
    "/etc/puppet/puppet.conf":
      content => template('puppet/main.erb', 'puppet/master.erb', 'puppet/agent.erb')
  }

  file { [
    "/etc/puppet/auth.conf",
    "/etc/puppet/fileserver.conf",
  ]:
      source => "puppet:///modules/puppet/$name"
  }

}
