default['et_elk']['server']['config']['output']['elasticsearch']['hosts'] = '127.0.0.1'

default['et_elk']['server']['config']['input']['lumberjack']['ssl_certificate'] =
  '/etc/logstash/lumberjack.crt.pem'
default['et_elk']['server']['config']['input']['lumberjack']['ssl_key'] = '/etc/logstash/lumberjack.key.pem'
default['et_elk']['server']['config']['input']['lumberjack']['host'] = '0.0.0.0'
default['et_elk']['server']['config']['input']['lumberjack']['port'] = 5043
default['et_elk']['server']['config']['input']['lumberjack']['codec'] = 'plain'
default['et_elk']['server']['config']['input']['lumberjack']['add_field']['x_proccessed_by'] =
  node['fqdn'] || node.name
default['et_elk']['server']['config']['input']['lumberjack']['add_field']['x_proccessor_chef_env'] =
  node.chef_environment

default['et_elk']['server']['config']['input']['log4j']['data_timeout'] = 5
default['et_elk']['server']['config']['input']['log4j']['host'] = '0.0.0.0'
default['et_elk']['server']['config']['input']['log4j']['mode'] = 'server'
default['et_elk']['server']['config']['input']['log4j']['port'] = 5044

# All input processors should leave tags indicating their names
default['et_elk']['server']['config']['input'].each_key do |input|
  default['et_elk']['server']['config']['input'][input]['add_field']['x_input_processor'] = input
end

default['et_elk']['logstash']['plugins'] = %w(logstash-filter-alter)
default['et_elk']['logstash']['version'] = '1:2.1.1-1'
