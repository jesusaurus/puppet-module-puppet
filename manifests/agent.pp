class puppet::agent (
  $mode = 'none',
) inherits puppet {

  if ! ($mode in [ 'none', 'cron', 'service', ]) {
    fail("Unknown agent mode: $mode")
  }

  file { "/etc/puppet/puppet.conf":
    content => template('puppet/main.erb', 'puppet/agent.erb')
  }

  case $mode {
    'service': {
      $service = true
      $cron    = absent
    }

    'cron': {
      $service = false
      $cron    = present
    }

    'none': {
      $service = false
      $cron    = absent
    }

  }

  service { "puppet":
    ensure    => $service,
    enable    => $service,
    subscribe => [
      File[ "/etc/puppet/puppet.conf" ],
    ],
  }

  cron { "puppet":
    ensure  => $cron,
    command => 'puppet agent --onetime --splay 60 --no-daemonize',
    minute  => [ fqdn_rand(30), fqdn_rand(30)+29 ],
  }

}
