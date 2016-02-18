require 'spec_helper'


describe command('curl http://localhost:80') do
    its(:stdout) { should contain 'appserver-1' }
end
  
describe command('curl http://localhost:80') do
    its(:stdout) { should contain 'appserver-2' }
end

=begin
describe 'server::loadbalancer' do
  it 'Check if loadbalancer listening on localhost' do
    expect(command('curl http://localhost:80').exit_status).to eq 0
  end
end
=end