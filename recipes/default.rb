# Install required packages
package node[:miner][:packages] do
  action :upgrade
end

# Make install media directory
directory node[:miner][:stage][:dir] do
  owner node[:miner][:admin]
  group node[:miner][:admin]
  mode  node[:miner][:stage][:mode]
  recursive true
  action :create
end

# Setup GPU driver
include_recipe 'team-miner::gpudriver'

# Setup Claymore
include_recipe 'team-miner::claymore'

# Configure Syslog
include_recipe 'team-miner::syslog'
