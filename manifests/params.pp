class puppet::params {
  
  # Site-wide parameters

  $puppetserver = "sand.rc.pdx.edu"

  $confdir = "/etc/puppet"
  $vardir  = "/var/lib/puppet"
  $logdir  = "/var/log/puppet"
  $ssldir  = "$vardir/ssl"

  $quiet = false

  $default_environment = "production"
  $dynamic_environments = true

  $storeconfigs = false
  $thinconfigs  = false

}
