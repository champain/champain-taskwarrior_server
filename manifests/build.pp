# This is probably a bad idea, but a good
# exercise. Build the taskwarrior server from
# source
class taskwarrior_server::build (
  String $task_git_source   = $taskwarrior_server::task_git_source,
  String $task_git_revision = $taskwarrior_server::task_git_revision,
  Array $build_packages     = $taskwarrior_server::build_packages,
) {

  package { $build_packages:
    ensure =>  present,
  }

  vcsrepo { '/opt/source/taskd.git':
    ensure   => present,
    provider => git,
    source   => $task_git_source,
    revision => $task_git_revision,
    require  => Package[ $build_packages ],
  }

  exec { 'cmake configure taskd':
    command     => 'cmake -DCMAKE_BUILD_TYPE=release .',
    cwd         => '/opt/source/taskd.git',
    path        => [ '/bin' ],
    refreshonly => true,
    subscribe   => Vcsrepo['/opt/source/taskd.git'],
  }

  exec { 'make taskd':
    command     => 'make',
    cwd         => '/opt/source/taskd.git',
    path        => [ '/bin' ],
    refreshonly => true,
    subscribe   => Vcsrepo['/opt/source/taskd.git'],
  }

  exec { 'make install taskd':
    command     => 'make install',
    cwd         => '/opt/source/taskd.git',
    path        => [ '/bin' ],
    refreshonly => true,
    subscribe   => Vcsrepo['/opt/source/taskd.git'],
  }

}
