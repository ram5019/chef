#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
package 'httpd' do
  action :install
  only_if 'cat /etc/redhat-release'
end
