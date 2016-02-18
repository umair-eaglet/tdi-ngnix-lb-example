#
# Cookbook Name:: server
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'server::appserver' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
	
	it 'install git' do
		expect(chef_run).to install_package('git')
	end

	it 'install golang' do
		expect(chef_run).to install_package('golang')
	end
	
	it 'create document root for app serving' do
		expect(chef_run).to create_directory('/var/www/appserver/public_html')
	end	
	
  end
end
