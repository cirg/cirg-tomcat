# == Class: tomcat
#
# Full description of class tomcat here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { tomcat:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class tomcat (
  $disable_authentication = hiera('tomcat::disable_authentication', false),
  $enable_ajp = hiera('tomcat::enable_ajp', false)
) {

  package { 'tomcat6':
    ensure => installed,
  }

  service { 'tomcat6':
    ensure    => running,
    enable    => true,
    subscribe => Package['tomcat6'],
  }

  file { '/etc/default/tomcat6':
    ensure  => present,
    content => template('tomcat/default.tomcat6.erb'),
    notify  => Service['tomcat6'],
    require => Package['tomcat6'],
  }

  file { '/etc/tomcat6/server.xml':
    ensure  => present,
    content => template('tomcat/server.xml.erb'),
    notify  => Service['tomcat6'],
    require => Package['tomcat6'],
  }

}
