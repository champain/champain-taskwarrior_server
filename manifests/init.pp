# Class: taskwarrior_server
# ===========================
#
# Full description of class taskwarrior_server here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'taskwarrior_server':
#      build_taskwarriord => false,
#    }
#
# Authors
# -------
#
# Author Name <jacobcastello@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2017 Jacob Castello, unless otherwise noted.
#
class taskwarrior_server ( 
  String $task_git_source     = 'https://git.tasktools.org/TM/taskd.git',
  String $task_git_revision   = 'master',
  Array $build_packages       = $::taskwarrior_server::params::build_packages,
  Boolean $build_taskwarriord = $::taskwarrior_server::params::build_taskwarriord,
) inherits ::taskwarrior_server::params {

  file { '/var/taskd':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/var/taskd/config':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('taskwarrior_server/config.erb'),
    require => File['/var/taskd'],
  }

  if $build_taskwarriord {
    include ::taskwarrior_server::build
  }

  if $::os['family'] == 'RedHat' and $::os['release']['major'] == '7' {
    class { '::taskwarrior_server::unit_file':
      require =>  Class['::taskwarrior_server::build'],
    }
  }

  service { 'taskd':
    ensure  => 'running',
    enable  => true,
  }

}
