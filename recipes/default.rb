# Install required packages
package node[:miner][:packages] do
  action :upgrade
end

# Make install media directory
directory node[:miner][:instmedia] do
  owner node[:team][:admin]
  group node[:team][:admin]
  mode '0755'
  recursive true
  action :create
end

# Setup GPU driver
include_recipe 'team-miner::gpudriver'

# Setup Claymore
include_recipe 'team-miner::claymore'
