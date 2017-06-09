require 'beaker-rspec'

logger.info("Loaded spec acceptance helper")

# Install Puppet on all hosts
install_puppet_agent_on(hosts, options)

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  module_name = module_root.split('-').last

  c.formatter = :documentation

  c.before :suite do
    # Install module to all hosts
    hosts.each do |host|
      puppet_module_install(:source => module_root, :module_name => module_name)
      # Install dependencies
      on(host, puppet('module', 'install', 'puppetlabs-stdlib'))
      on(host, puppet('module', 'install', 'puppetlabs-vcsrepo'))
      # Add more setup code as needed
    end
  end
end
