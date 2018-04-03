#
# Cookbook Name:: chef-provisioning
# Attribute:: default
#
# Copyright (C) 2014 Bloomberg L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Set this if you want a specific version of chef-provisioning.
default['chef-provisioning']['version'] = nil

# Set these if you want a specific version of chef-provisioning drivers.
default['chef-provisioning']['docker']['version'] = nil
default['chef-provisioning']['fog']['version'] = nil
default['chef-provisioning']['lxc']['version'] = nil
default['chef-provisioning']['ssh']['version'] = nil
default['chef-provisioning']['vagrant']['version'] = nil
default['chef-provisioning']['vsphere']['version'] = nil
