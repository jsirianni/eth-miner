# Place syslog conf and start or stop the service
template "/etc/rsyslog.d/60-syslog.conf" do
      user     'root'
      group    'root'
      source   '60-syslog.conf.erb'
      mode     '0644'
      action   :create

      if node[:miner][:enablesyslog] != false
            notifies :restart, 'service[rsyslog]'
      end
end

# Manage the syslog service
service 'rsyslog' do
      if node[:miner][:enablesyslog] != false
            action [:enable, :start]
      else
            action [:disable, :stop]
      end
end
