class puppet::params {
  
  # Site-wide parameters

  $puppetserver = "10.7.0.1"

  $confdir = "/etc/puppet"
  $vardir  = "/var/lib/puppet"
  $logdir  = "/var/log/puppet"
  $ssldir  = "$vardir/ssl"

  $quiet = false

  $default_environment = "production"
  $dynamic_environments = true

  $storeconfigs = false

}
