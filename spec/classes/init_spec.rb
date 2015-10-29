require 'spec_helper'
describe 'dump' do

  context 'with defaults for all parameters' do
    it { should contain_class('dump') }
  end
end
