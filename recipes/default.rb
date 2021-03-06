# Install required packages
package node[:miner][:packages] do
  action :install
end

# Make install media directory
directory node[:miner][:stage][:dir] do
  mode  node[:miner][:stage][:mode]
  recursive true
  action :create
end

# Setup GPU driver
include_recipe 'eth-miner::gpudriver'

# Setup Claymore
include_recipe 'eth-miner::claymore'

# Configure Syslog
include_recipe 'eth-miner::syslog'
