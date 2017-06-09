# The params class for taskwarrior_server
# There's a lot of debate about whether or
# not to even have these. This has been created
# with future functionality in mind.

class taskwarrior_server::params {

  if $::osfamily == 'RedHat' {
      $build_packages = [
        'git',
        'libuuid',
        'libuuid-devel',
        'gnutls',
        'gnutls-c++',
        'gnutls-devel',
        'gnutls-utils',
        'make',
        'cmake',
        'gcc',
        'gcc-c++',
      ]
    $build_taskwarriord = true
  } else {
    $build_taskwarriord = false
  }
}
