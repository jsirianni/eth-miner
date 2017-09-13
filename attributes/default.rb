
# Env
default[:miner][:packages] = ['libcurl3','screen','lm-sensors']

# Sources
default[:miner][:gpu_driver_source] = 'https://www2.ati.com/drivers/linux/ubuntu/amdgpu-pro-17.10-414273.tar.xz'
default[:miner][:claymore_source] = 'https://github.com/nanopool/Claymore-Dual-Miner/releases/download/v9.5/Claymore.s.Dual.Ethereum.Decred_Siacoin_Lbry_Pascal.AMD.NVIDIA.GPU.Miner.v9.5.-.LINUX.tar.gz'

# Install directories
default[:miner][:instmedia] = '/apps/instmedia'
default[:miner][:miner_install_dir] = '/usr/local/claymore95'

# GPU Driver
default[:miner][:driver_version] = 'amdgpu-pro-17.10-414273'
default[:miner][:driver_archive] = "#{node[:miner][:driver_version]}.tar.xz"
default[:miner][:driver_installer_dir] = "#{node[:miner][:instmedia]}/#{node[:miner][:driver_version]}"
default[:miner][:driver_installer] = 'amdgpu-pro-install'

# Claymore
default[:miner][:claymore_archive] = 'claymore.tar.gz'
default[:miner][:claymore_dir] = '/usr/local/claymore95'
default[:miner][:claymore_executable] = "#{node[:miner][:claymore_dir]}/ethdcrminer64"

# Get the hostname, drop the domain name
default[:miner][:worker_name] = node.name.split('.')[0]

# Etherium
default[:miner][:address] = 'overrideme'
