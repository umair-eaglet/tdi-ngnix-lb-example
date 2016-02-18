#
# Cookbook Name:: server
# Recipe:: loadbalancer
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'nginx'

template node['loadbalancer']['sites-available'] do
  source 'loadbalancer.conf.erb'
  variables({
    :upstream_servers => node[:loadbalancer][:upstream_servers]
  })
  notifies :restart, resources(:service => "nginx")
end