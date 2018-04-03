#
# Cookbook Name:: bamboo
# Recipe:: apache2
#
# Copyright 2014
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
node.default['apache']['listen'] += ["*:#{node['bamboo']['apache2']['port']}"]
node.default['apache']['listen'] += ["*:#{node['bamboo']['apache2']['ssl']['port']}"]

include_recipe 'apache2'
include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'
include_recipe 'apache2::mod_ssl'

web_app bamboo_virtual_host_alias do
  cookbook node['bamboo']['apache2']['template_cookbook']
end
