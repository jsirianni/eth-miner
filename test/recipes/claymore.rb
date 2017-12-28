claymoredir = '/usr/local/claymore95'
claymorebin = '/usr/local/claymore95/ethdcrminer64'
claymoreunit = '/etc/systemd/system/claymore.service'
claymoresrv = 'claymore'


describe file(claymoredir) do
  it { should exist }
  it { should be_directory }
end


describe file(claymorebin) do
  it { should exist }
end


describe file(claymoreunit) do
  it { should exist }
  its('mode') { should cmp '0640'}
end


describe service claymoresrv do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
