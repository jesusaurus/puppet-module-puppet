class puppet {
  # This class contains resources common to both master and agent

  include puppet::params

  file {
    "/etc/puppet/auth.conf":
      source => "puppet:///modules/puppet/$name"
  }
}
