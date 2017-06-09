require 'spec_helper_acceptance'

describe 'taskwarrior_server class' do
  it 'should work with no errors based on the example' do
    expect(apply_manifest('include ::taskwarrior_server')).to_not eq(1)
  end

  describe file('/var/taskd/config') do
    it { should exist }
    it { should be_file }
    its(:content) { should match /log=\/var\/log\/taskd.log/ }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
  end
end
