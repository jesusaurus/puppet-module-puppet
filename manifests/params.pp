class puppet::params (
  
  # Site-wide parameters

  $puppetmaster = "puppet",

  $confdir = "/etc/puppet",
  $vardir  = "/var/lib/puppet",
  $logdir  = "/var/log/puppet",
  $ssldir  = "$vardir/ssl",

  $quiet  = false,
  $report = true,

  $pluginsync = true,

  $default_environment  = "production",
  $dynamic_environments = true,

  $storeconfigs = true,
  $thinconfigs  = false,

  $dbadapter  = "puppetdb",
  $dbserver   = "localhost",
  $dbname     = "puppet",
  $dbuser     = "puppet",
  $dbpassword = "password",

) {
  # empty class
}
