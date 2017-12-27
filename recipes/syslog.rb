# Manage the syslog service
service node[:miner][:log][:service] do
  action [:enable, :start]
end

# Place remote syslog conf
template node[:miner][:log][:remote_conf] do
  user     'root'
  group    'root'
  mode     '0644'
  action   :create
  source   node[:miner][:log][:remote_template]
  notifies :restart, "service[#{node[:miner][:log][:service]}]"
end

# Place claymore syslog conf
template node[:miner][:log][:claymore_conf] do
  user     'root'
  group    'root'
  mode     '0644'
  action   :create
  source   node[:miner][:log][:claymore_template]
  notifies :restart, "service[#{node[:miner][:log][:service]}]"
end
