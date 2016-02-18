Overview
========

This is high level example of chef provisioning using Test Driven Infrastructure (TDI). Upon kitchen creation  2 Application Servers [Appserver-(1/2)] running Golang and a load balancer will be created using Vagrant. An ngix load balancer serves application pages (running on Appservers ) in round robin fashion. The latest version of the application code could be deployed to by pushing latest version to Application repository and running Deploy recipe to get and build the latest version of application.

Note: It required Chef DK 12 or higher version installed along with VM Virtual Box and Vagrant installed

Quik Recipes Intro
======================
A Server Cookbook contains all the recipes required to create the Infrastructure and Deploy application.⋅⋅
Appserver recipe contains all the code necessary to run Golang server.⋅⋅
Loadbalancer recipe installs and configure nginx for load balancing in Round Robin fashion ( Default nginx )⋅⋅
Deploy recipe deals with deployment and running Go App.

Quick Commands
======================

 1. Run "kitchen Converge" in command line while in Server Cookbook directory
    Once all servers are converged then you can see results on localhost & port 8182 by running http://localhost:8182/

 Chef recipes are written using Test Driven approach
 2. In order to run unit test for each recipe, run following command
    ..2.1 chef exec rspec .\spec\unit\recipes\appserver_spec.rb           //Run ChefSpec unit tests for appserver recipe
    2.2 chef exec rspec .\spec\unit\recipes\loadbalancer_spec.rb        //Run ChefSpec unit tests for loadbalancer recipe
    2.3 chef exec rspec .\spec\unit\recipes\deploy_spec.rb              //Run ChefSpec unit tests for deploy recipe


 3. In order to run integration run following commands
   ..3.1  kitchen verify appserver-1-centos-71      //For appserver-1
   3.2  kitchen verify appserver-2-centos-71      //For appserver-2
   3.3  kitchen verify load-balancer-centos-71    //For load balancer

General Settings
=============
Following attributes are set in corresponding attributes files to be used in recipes
default['appserver']['deploy_to'] = '/path/to/deploy/app'
default['appserver']['repo'] = 'https://github.com/your-git-account/your-app-on.git'
default['appserver']['document_root'] = '/path/to/webroot'
