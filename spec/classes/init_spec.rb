require 'spec_helper'
describe 'pam_mount' do

  context 'with defaults for all parameters' do
    it { should contain_class('pam_mount') }
  end
end
