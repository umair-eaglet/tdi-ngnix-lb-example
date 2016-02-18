#
# Cookbook Name:: server
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Create the document root directory.
directory node['appserver']['deploy_to'] do
	owner node['appserver']['user']
  recursive true
end

#Deploy Go App from Git
deploy 'myapp' do
  repo node['appserver']['repo']
  user node['appserver']['user']
  deploy_to node['appserver']['deploy_to']
  
  
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks.clear
  
  action :deploy
end

#Build latest version of Go App from current release deployed in web-root
execute "build-myapp" do
  command "go build -o #{node['appserver']['document_root']}/myapp #{node['appserver']['deploy_to']}/current/src/myapp/index.go"
end

#Kill already running prevision of Go App
execute "stop-myapp" do
  command "kill $(cat #{node['appserver']['document_root']}/pid.txt) || true"
end

#Run Go App in BG
execute "run-myapp" do
  command "#{node['appserver']['document_root']}/myapp  & echo $! > #{node['appserver']['document_root']}/pid.txt"
end