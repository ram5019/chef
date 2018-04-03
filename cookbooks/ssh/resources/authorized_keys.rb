actions :add, :remove, :update
default_action :add

attribute :type,
          :kind_of => String,
          :default => 'ssh-rsa',
          :equal_to => [
            'ssh-rsa',
            'ecdsa-sha2-nistp256',
            'ecdsa-sha2-nistp384',
            'ecdsa-sha2-nistp521',
            'ssh-ed25519',
            'ssh-dss'
          ]
attribute :options, :kind_of => Hash, :default => {}
attribute :key, :kind_of => String, :required => true, :regex => [/^\S*$/]
attribute :comment, :kind_of => String
attribute :user, :kind_of => String, :required => true

attr_accessor :exists
alias exists? exists
