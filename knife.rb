current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
knife[:editor]="/usr/bin/vim"
node_name                "ramakrishna"
client_key               "#{current_dir}/ramakrishna.pem"
chef_server_url          "https://chef.example.com/organizations/chefserver"
cookbook_path            "/root/.chef/cookbooks"
validation_client_name   'chefserver-validator'
validation_key           'validator.pem'

