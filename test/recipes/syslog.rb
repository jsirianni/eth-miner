logservice = 'rsyslog'
logconf = '/etc/rsyslog.d/60-syslog.conf'


describe file(logconf) do
  it { should exist }
end


describe service logservice do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
