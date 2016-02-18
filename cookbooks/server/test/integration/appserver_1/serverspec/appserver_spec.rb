require 'spec_helper'

describe port(8484) do
  it { should be_listening }
end

describe interface('enp0s8') do
  it { should have_ipv4_address('192.168.1.2') }
end

describe command('curl http://localhost:8484') do
    its(:stdout) { should contain 'appserver-1' }
 end
  