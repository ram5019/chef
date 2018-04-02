log_level                 :info
log_location              STDOUT
node_name                 'chefserver'
client_key                "#{ENV['HOME']}/.chef/ramakrishna.pem"
validation_client_name    'chef-validator'
validation_key            "#{ENV['HOME']}/.chef/validator.pem"
chef_server_url           'https://chef.example.com:443'
syntax_check_cache_path   "#{ENV['HOME']}/.chef/syntax_check_cache"
