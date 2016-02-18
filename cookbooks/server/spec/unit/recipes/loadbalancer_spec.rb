#
# Cookbook Name:: server
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'server::loadbalancer' do
  context 'When all attributes are default, on an unspecified platform' do
    	
	before(:each) do
	  stub_command('which nginx').and_return(true)
	end
	
	let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end
	
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

	it 'include recipe nginx' do
		expect(chef_run).to include_recipe('nginx')
	end	
	
	it 'create template /etc/nginx/sites-available/default' do
		expect(chef_run).to create_template('/etc/nginx/sites-available/default')
	end	
	
  end
end
