class puppet::puppetdb (
  $server => "localhost",
  $port   => '8081',
) {

  package { 'puppetdb-terminus':
    ensure => present,
  }

  file { "/etc/puppet/puppetdb.conf":
    ensure  => present,
    content => template('puppet/puppetdb.erb'),
  }

  file {"/etc/puppet/routes.yaml":
    ensure  => present,
    content => template('puppet/routes.erb'),
  }

}
