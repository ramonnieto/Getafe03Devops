current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                'chef_user'
client_key               "#{current_dir}/chef_user.pem"
chef_server_url          'http://localhost:8889'
cookbook_path            ["#{current_dir}/../cookbooks"]
