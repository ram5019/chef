#
# Cookbook:: host
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

hostsfile_entry '192.168.122.235' do
  hostname  'server.example.com'
  aliases   ['server']
  comment   'Append by Recipe X'
  action    :append
end
