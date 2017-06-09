# Include the unit file in systemd installs
class taskwarrior_server::unit_file (){

  file{ '/etc/systemd/system/taskd.service':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('taskwarrior_server/taskd.service.erb'),
  }
}
