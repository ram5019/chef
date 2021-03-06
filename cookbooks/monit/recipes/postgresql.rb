#
# Copyright 2015, Noah Kantrowitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Some code used under MIT license
# Copyright Alex Soto
#

include_recipe 'monit'

monit_config 'postgresql' do
  content <<-EOH
CHECK PROCESS postgresql WITH PIDFILE #{node['monit']['postgres']['pid_file']}
  start program = "/etc/init.d/postgresql start"
  stop  program = "/etc/init.d/postgresql stop"
  GROUP postgres
  IF FAILED UNIXSOCKET #{node['monit']['postgres']['unix_socket_path']}.#{node['monit']['postgres']['port']} PROTOCOL pgsql THEN RESTART
  IF FAILED HOST 127.0.0.1 PORT #{node['monit']['postgres']['port']} PROTOCOL pgsql THEN RESTART
  IF 5 RESTARTS WITHIN 5 CYCLES THEN TIMEOUT
EOH
end
