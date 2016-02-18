#
# Cookbook Name:: server
# Recipe:: appserver
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#install git on server
package 'git' do
	action :install
end

#install golang 
package 'golang' do
	action :install
end

# Create the app serving directory.
directory node['appserver']['document_root'] do
	owner node['appserver']['user']
	recursive true
end
