# ATTRIBUTES THAT SHOULD BE OVERRIDEN
default[:miner][:address] = "overrideme"


# Package dependencies
default[:miner][:packages] = ["wget", "curl", "libcurl3", "lm-sensors", "rsyslog"]


# Staging directory for install media - override this if tmp is not okay
default[:miner][:stage][:dir]  = "/tmp/instmedia"
default[:miner][:stage][:mode] = "700"


# GPU Driver
default[:miner][:amd][:source]    = "https://www2.ati.com/drivers/linux/ubuntu/amdgpu-pro-17.10-414273.tar.xz"
default[:miner][:amd][:version]   = "amdgpu-pro-17.10-414273"
default[:miner][:amd][:archive]   = "amdgpu-pro-17.10-414273.tar.xz"
default[:miner][:amd][:src_dir]   = "/tmp/instmedia/amdgpu-pro-17.10-414273"
default[:miner][:amd][:installer] = "amdgpu-pro-install"
default[:miner][:amd][:group]     = "video"

# Claymore
default[:miner][:claymore][:source]     = "https://github.com/nanopool/Claymore-Dual-Miner/releases/download/v9.5/Claymore.s.Dual.Ethereum.Decred_Siacoin_Lbry_Pascal.AMD.NVIDIA.GPU.Miner.v9.5.-.LINUX.tar.gz"
default[:miner][:claymore][:archive]    = "claymore.tar.gz"
default[:miner][:claymore][:inst_dir]   = "/usr/local/claymore95"
default[:miner][:claymore][:executable] = "/usr/local/claymore95/ethdcrminer64"
default[:miner][:claymore][:pool]       = "us1.ethermine.org:4444"
default[:miner][:claymore][:worker]     = node[:fqdn].split(".")[0]

# Syslog
default[:miner][:log][:socket]            = "myhost:port"
default[:miner][:log][:service]           = "rsyslog"
default[:miner][:log][:claymore_conf]     = "/etc/rsyslog.d/claymore_log.conf"
default[:miner][:log][:remote_conf]       = "/etc/rsyslog.d/60-syslog.conf"
default[:miner][:log][:claymore_template] = "claymore_log.conf.erb"
default[:miner][:log][:remote_template]   = "60-syslog.conf.erb"
