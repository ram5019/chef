# Encoding: utf-8
# Cookbook Name:: kibana
# Resource/Provider:: install
# Author:: John E. Vincent
# Author:: Paul Czarkowski
# License:: Apache 2.0
#
# Copyright 2014, John E. Vincent

class Chef
  class Resource::KibanaInstall < Chef::Resource::LWRPBase
    provides :kibana_install
    actions(:create, :remove)
    default_action(:create)

    attribute(:name, kind_of: String, name_attribute: true)
    attribute(:user, kind_of: String, default: 'kibana')
    attribute(:group, kind_of: String, default: 'kibana')
    attribute(:install_dir, kind_of: String, default: '/opt/kibana')
    attribute(:install_type, kind_of: String, default: 'file')
    attribute(:git_branch, kind_of: String, default: lazy { node['kibana']['git']['branch'] })
    attribute(:git_url, kind_of: String, default: lazy { node['kibana']['git']['url'] })
    attribute(:git_type, kind_of: String, default: lazy { node['kibana']['git']['type'] })
    attribute(:file_type, kind_of: String, default: lazy { node['kibana']['file']['type'] })
    attribute(:file_url, kind_of: String, default: lazy { node['kibana']['file']['url'] })
    attribute(:version, kind_of: String, default: lazy { node['kibana']['version'] })
    attribute(:file_checksum, kind_of: String, default: lazy { node['kibana']['file']['checksum'] })
  end

  class Provider::KibanaInstall < Chef::Provider::LWRPBase # ~FC057, ~FC058
    provides :kibana_install
    include Chef::DSL::Recipe # required under chef 12, see poise/poise #8

    action :remove do
      converge_by("remove resource #{new_resource.name}") do
        kb_args = kibana_resources

        directory kb_args[:install_dir] do
          recursive true
          action :delete
        end
      end
    end

    action :create do
      kb_args = kibana_resources

      if kb_args[:file_url] && !kb_args[:file_url].include?(kb_args[:version])
        Chef::Log.warn("You supplied a download URL and Kibana version, but they don't appear to match (#{kb_args[:version]} version isn't in URL #{kb_args[:file_url]})")
      end

      converge_by("create resource #{new_resource.name}") do
        directory kb_args[:install_dir] do
          recursive true
          owner kb_args[:user]
          group kb_args[:group]
          mode '0755'
        end

        case kb_args[:install_type]
        when 'git'
          @run_context.include_recipe 'git::default'
          git "#{kb_args[:install_dir]}/#{kb_args[:git_branch]}" do
            repository kb_args[:git_url]
            reference kb_args[:git_branch]
            action kb_args[:git_type].to_sym
            user kb_args[:user]
          end

          link "#{kb_args[:install_dir]}/current" do
            to "#{kb_args[:install_dir]}/#{kb_args[:git_branch]}/src"
          end
          node.set['kibana'][kb_args[:name]]['web_dir'] = "#{kb_args[:install_dir]}/current/src"

        when 'file'
          @run_context.include_recipe 'libarchive::default'
          temp_file = "kibana_#{kb_args[:name]}_#{kb_args[:version]}_#{kb_args[:name]}.tar.gz"
          temp_path = Chef::Config[:file_cache_path]
          case kb_args[:file_type]
          when 'tgz', 'zip'
            download_url = kb_args[:file_url] || "https://download.elastic.co/kibana/kibana/kibana-#{kb_args[:version]}.tar.gz"
            remote_file "#{temp_path}/#{temp_file}" do
              checksum lazy { kb_args[:file_checksum] }
              source download_url
              action [:create]
            end

            libarchive_file temp_file do
              path "#{temp_path}/#{temp_file}"
              extract_to kb_args[:install_dir]
              owner kb_args[:user]
              action [:extract]
              not_if { ::File.exist?("#{kb_args[:install_dir]}/kibana-#{kb_args[:version]}") }
            end

            link "#{kb_args[:install_dir]}/current" do
              to "#{kb_args[:install_dir]}/kibana-#{kb_args[:version]}"
            end

            node.set['kibana'][kb_args[:name]]['web_dir'] = "#{kb_args[:install_dir]}/current"
            node.save unless Chef::Config[:solo]
          end
        end # end case
      end # end converge by
    end # end create def

    private

    def kibana_resources
      kb = {
        name: new_resource.name,
        user: new_resource.user,
        group: new_resource.group,
        install_dir: new_resource.install_dir,
        install_type: new_resource.install_type,
        git_branch: new_resource.git_branch,
        git_url: new_resource.git_url,
        git_type: new_resource.git_type,
        file_type: new_resource.file_type,
        file_url: new_resource.file_url,
        version: new_resource.version,
        file_checksum: new_resource.file_checksum
      }
      kb
    end
  end # end class
end # end classes
