#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

file '/tmp/test.txt' do
  action :create
  content 'welcom to chef world'
  mode '0755'
end
