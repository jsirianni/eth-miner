# TODO #
# - Make driver install idempotence
# - Make user group mode idempotence
# - Add ability to upgrade driver

return if node[:miner].attribute?(:driver_installed)

# Download gpu driver
bash 'download gpu driver' do
  user   node[:miner][:user]
  group  node[:miner][:user]
  cwd    node[:miner][:stage][:dir]
  code   "wget --referer=http://support.amd.com #{node[:miner][:amd][:source]}"
  not_if { ::File.exist?("#{node[:miner][:stage][:dir]}/#{node[:miner][:amd][:archive]}") }
end

# Extract GPU driver
bash 'extract gpu driver' do
  user   node[:miner][:user]
  group  node[:miner][:user]
  cwd    node[:miner][:stage][:dir]
  code   "tar -xvf #{node[:miner][:amd][:archive]}"
  not_if { ::File.exist?("#{node[:miner][:stage][:dir]}/#{node[:miner][:amd][:version]}/#{node[:miner][:amd][:installer]}") }
end

# Run GPU installer
bash 'run amd installer' do
   cwd     node[:miner][:amd][:src_dir]
   code    "sudo ./#{node[:miner][:amd][:installer]} -y"
   timeout 36000
end

# Add miner user to the video group
group node[:miner][:amd][:group] do
  action  :modify
  members node[:miner][:user]
  append  true
end

# Set installed
ruby_block 'set driver as installed' do
  block do
      node.set[:miner][:driver_installed] = true
  end
end
