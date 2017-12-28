# TODO #
# - Make driver install idempotence
# - Make user group mode idempotence
# - Add ability to upgrade driver


# Download gpu driver
execute 'download_gpu_driver' do
  cwd     node[:miner][:stage][:dir]
  command "wget --referer=http://support.amd.com #{node[:miner][:amd][:source]}"
  not_if  { ::File.exist?("#{node[:miner][:stage][:dir]}/#{node[:miner][:amd][:archive]}") }
end

# Extract GPU driver
execute 'extract_gpu_driver' do
  cwd     node[:miner][:stage][:dir]
  command "tar -xvf #{node[:miner][:amd][:archive]}"
  not_if  { ::File.exist?("#{node[:miner][:stage][:dir]}/#{node[:miner][:amd][:version]}/#{node[:miner][:amd][:installer]}") }
end


# Do not run installed if driver is installed
return if node[:miner].attribute?(:driver_installed)

# Run GPU installer
execute 'run_amd_installer' do
   cwd     node[:miner][:amd][:src_dir]
   command "#{node[:miner][:stage][:dir]}/#{node[:miner][:amd][:version]}/#{node[:miner][:amd][:installer]} -y"
   timeout 36000
end

# Set installed
ruby_block 'set_driver_as_installed' do
  block do
      node.set[:miner][:driver_installed] = true
  end
end
