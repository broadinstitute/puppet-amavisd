require 'spec_helper'
describe 'amavisd' do

  context 'with defaults for all parameters' do
    it { should contain_class('amavisd') }
  end
end
