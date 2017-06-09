# Class: taskwarrior_server
# ===========================
#
# taskwarrior_server aims to install and configure
# taskd, the server component of taskwarrior
# that enables a user to share task lists among
# devices with the taskwarrior client or application
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `task_git_source`
# This is the git repo from which taskd is cloned
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
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
