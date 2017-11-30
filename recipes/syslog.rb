if node[:miner][:enablesyslog] != false
      # Place syslog conf
      template "/etc/rsyslog.d/60-syslog.conf" do
        user     'root'
        group    'root'
        source   '60-syslog.conf.erb'
        mode     '0644'
        notifies :restart, 'service[rsyslog]'
        action   :create
      end

      # Restart rsyslog if template updated
      service 'rsyslog' do
            action :nothing
      end
else
      service 'rsyslog' do
            action :stop
      end
end
