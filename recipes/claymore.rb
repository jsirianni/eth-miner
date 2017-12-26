# Make miner install directory
directory node[:miner][:claymore][:inst_dir] do
  owner node[:miner][:user]
  group node[:miner][:user]
  mode '0700'
  recursive true
  action :create
end

# Download claymore
remote_file "#{node[:miner][:stage][:dir]}/#{node[:miner][:claymore][:archive]}" do
  user     node[:miner][:user]
  group    node[:miner][:user]
  source   node[:miner][:claymore][:source]
  not_if   { ::File.exist?("#{node[:miner][:instmedia]}/#{node[:miner][:claymore][:archive]}") }
end

# Extract claymore
bash 'extract claymore' do
  user     node[:miner][:user]
  group    node[:miner][:user]
  cwd      node[:miner][:instmedia]
  code     "tar -xvf #{node[:miner][:claymore][:archive]} -C #{node[:miner][:claymore][:inst_dir]}"
  not_if   { ::File.exist?("#{node[:miner][:claymore][:executable]}") }
end

# Place Claymore SystemD Service File
template node[:miner][:claymore][:systend_file] do
  user     "root"
  group    "root"
  source   node[:miner][:claymore][:srv_template]
  action   :create
end

# Manage the claymore service
service node[:miner][:claymore][:service] do
  action [:enable, :start]
  subscribes :reload, 'template[/etc/samba/smb.conf]', :immediately
end
