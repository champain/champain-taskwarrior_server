require 'spec_helper'
describe 'taskwarrior_server' do
  context 'with default values for all parameters' do
    it { should contain_class('taskwarrior_server') }
  end
end
