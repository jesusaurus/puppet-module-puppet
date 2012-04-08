class puppet::params {

  # Site-wide parameters

  $puppetmaster = "puppet"

  $confdir = "/etc/puppet"
  $vardir  = "/var/lib/puppet"
  $logdir  = "/var/log/puppet"
  $ssldir  = "$vardir/ssl"

  $quiet = false

  $default_environment = "production"
  $dynamic_environments = true

  $storeconfigs = true
  $thinconfigs  = true

  $dbadapter  = "postgresql"
  $dbserver   = "localhost"
  $dbname     = "puppet"
  $dbuser     = "puppet"
  $dbpassword = "password"

}
