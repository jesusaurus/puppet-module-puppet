class puppet::hiera {

  package { 'hiera':
    provider => gem,
    ensure   => present,
  }

  package { 'hiera-puppet':
    provider => gem,
    ensure   => present,
  }

  package { 'hiera-file':
    provider => gem,
    ensure   => present,
  }

  file { "$confdir/hiera.yaml":
    ensure  => present,
    content => template("puppet/hiera.erb"),
  }

}
