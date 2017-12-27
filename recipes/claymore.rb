# Make miner install directory
directory node[:miner][:claymore][:inst_dir] do
  owner     node[:miner][:user]
  group     node[:miner][:user]
  mode      '0700'
  recursive true
  action    :create
end

# Download claymore
remote_file "#{node[:miner][:stage][:dir]}/#{node[:miner][:claymore][:archive]}" do
  user   node[:miner][:user]
  group  node[:miner][:user]
  source node[:miner][:claymore][:source]
  not_if { ::File.exist?("#{node[:miner][:instmedia]}/#{node[:miner][:claymore][:archive]}") }
end

# Extract claymore
execute 'extract claymore' do
  user    node[:miner][:user]
  group   node[:miner][:user]
  cwd     node[:miner][:stage][:dir]
  command "tar -xvf #{node[:miner][:claymore][:archive]} -C #{node[:miner][:claymore][:inst_dir]}"
  not_if  { ::File.exist?("#{node[:miner][:claymore][:executable]}") }
end



# Manage the claymore service
# Restart systemd when unit file is updated.
# Restart claymore service when unit file is updated (delayed)

# Place claymore systemd unit file
template "/etc/systemd/system/claymore.service" do
  source   "claymore.service.erb"
  action   :create
  notifies :run, "execute[reload_systemd]", :immediately
end

# Reload systemd if template updated - restart claymore
execute 'reload_systemd' do
  command  "systemctl daemon-reload"
  action   :nothing
  notifies :restart, "service[claymore]", :immediately
end

# Enable and start claymore
service "claymore" do
  action [:enable, :start]
end
