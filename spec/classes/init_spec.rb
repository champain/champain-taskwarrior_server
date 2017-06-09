require 'spec_helper'
describe 'taskwarrior_server' do
  context 'with default values for all parameters' do
    let(:facts){
      { 
      :fqdn => 'localhost.local',
      :osfamily => 'RedHat',
      :os => { 
        :architecture => 'x86_64', 
        :family => 'RedHat', 
        :hardware => 'x86_64', 
        :name => 'CentOS', 
        :release => { 
           :full => '7.2.1511',
           :major => '7',
           :minor => '2' 
        } 
      }
    }
  }

    it { is_expected.to compile }
    it { is_expected.to contain_class('taskwarrior_server') }
    it do
      is_expected.to contain_file('/var/taskd/config').with({
        'ensure'  => 'file',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      })
    end
  end
end
