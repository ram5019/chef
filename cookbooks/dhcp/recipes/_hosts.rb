# Hosts
#
unless node['dhcp']['hosts'].empty?

  # special key to just use all hosts in dhcp_hosts databag
  # figure which hosts to load
  # TODO: this should be refactored into libs
  # rubocop:disable BlockNesting
  host_list = node['dhcp']['hosts']
  if host_list.respond_to?(:downcase) && host_list.casecmp('all') == 0
    host_list = node['dhcp']['host_data'].keys
    if node['dhcp']['use_bags'] == true
      begin
        host_list = data_bag(node['dhcp']['hosts_bag'])
        # TODO: Make this more specific to the non existing bag
      rescue
        return
      end
    end
  elsif node['dhcp']['use_bags'] == true
    search(node['dhcp']['hosts_bag'], "id:#{node['dhcp']['hosts_bag']}").each do |host|
      host_list << host['id']
    end
  end
  # rubocop:enable all

  host_list.each do |host|
    host_data = if node['dhcp']['use_bags'] == true
                  data_bag_item(node['dhcp']['hosts_bag'], Dhcp::Helpers.escape(host))
                else
                  node['dhcp']['host_data'].fetch host, nil
                end

    next unless host_data
    dhcp_host host do
      hostname host_data['hostname']
      macaddress host_data['mac']
      ipaddress host_data['ip']
      parameters host_data['parameters'] || []
      options host_data['options'] || []
      conf_dir node['dhcp']['dir']
    end
  end
end
