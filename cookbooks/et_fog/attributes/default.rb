default['et_fog']['version'] = '1.37.0'
default['et_fog']['dependencies'] =
  if platform_family? 'debian'
    %w(libxslt-dev libxml2-dev libghc-zlib-dev)
  elsif platform_family? 'rhel'
    %w(libxslt-devel libxml2-devel)
  end

set['build-essential']['compile_time'] = true
set['apt']['compile_time_update'] = true
