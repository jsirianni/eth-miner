return if node[:miner].attribute?(:driver_installed)

# Download gpu driver
bash 'download gpu driver' do
  user     node[:team][:admin]
  group    node[:team][:admin]
  cwd      node[:miner][:instmedia]
  code     "wget --referer=http://support.amd.com https://www2.ati.com/drivers/linux/ubuntu/amdgpu-pro-17.10-414273.tar.xz"
  not_if   { ::File.exist?("#{node[:miner][:instmedia]}/#{node[:miner][:driver_archive]}") }
end

# Extract GPU driver
bash 'extract gpu driver' do
  user     node[:team][:admin]
  group    node[:team][:admin]
  cwd      node[:miner][:instmedia]
  code     "tar -xvf #{node[:miner][:driver_archive]}"
  not_if   { ::File.exist?("#{node[:miner][:instmedia]}/#{node[:miner][:driver_version]}/#{node[:miner][:driver_installer]}") }
end

# Run GPU installer
bash 'run driver installer' do
   cwd     node[:miner][:driver_installer_dir]
   code    "sudo ./#{node[:miner][:driver_installer]} -y"
   timeout 36000
end

# Set installed
ruby_block 'set driver as installed' do
  block do
      node.set[:miner][:driver_installed] = true
  end
end
