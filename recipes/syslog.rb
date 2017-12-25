# Place syslog conf and start or stop the service
template node[:mienr][:log][:conf] do
      user     'root'
      group    'root'
      source   node[:miner][:log][:template]
      mode     '0644'
      action   :create

      if node[:miner][:log][:enablesyslog] != false
            notifies :restart, "service[#{node[:miner][:log][:service]}]"
      end
end

# Manage the syslog service
service node[:miner][:log][:service] do
      if node[:miner][:log][:enable] != false
            action [:enable, :start]
      else
            action [:disable, :stop]
      end
end
