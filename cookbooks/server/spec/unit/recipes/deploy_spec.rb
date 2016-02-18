#
# Cookbook Name:: server
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'server::deploy' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
	
	#Directory created for deployment.
	it 'create deployment directory' do
		expect(chef_run).to create_directory('/usr/local/src/myapp')
	end		
	
	#Application deploy successfully from given repo
	it 'application deployed from repo' do
		expect(chef_run).to deploy_deploy('myapp').with_repo('https://github.com/umair-eaglet/test-go-app.git')
	end	
	
	#Application built successfully
	it 'command executes to build Go application' do
		expect(chef_run).to run_execute('go build -o /var/www/appserver/public_html/myapp /usr/local/src/myapp/current/src/myapp/index.go')
	end	
	
	#Older version of App terminated to run newer version
	it 'command executes to kill the older version of app' do
		expect(chef_run).to run_execute('kill $(cat /var/www/appserver/public_html/pid.txt) || true')
	end	
	
	#Application run successfully
	it 'command executes to run Go app' do
		expect(chef_run).to run_execute('/var/www/appserver/public_html/myapp  & echo $! > /var/www/appserver/public_html/pid.txt')
	end	
	
  end
end
