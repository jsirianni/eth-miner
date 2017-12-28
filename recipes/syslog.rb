# Manage the syslog service
service 'rsyslog' do
  action [:enable, :start]
end

# Place remote syslog conf
template node[:miner][:log][:conf] do
  mode     '0644'
  action   :create
  source   node[:miner][:log][:remote_template]
  notifies :restart, 'service[rsyslog]'
end
