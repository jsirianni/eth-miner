packages = ['wget', 'lm-sensors', 'rsyslog']
stagedir = '/tmp/instmedia'
stagedirmode = '0700'


packages.each do |pkg|
  describe package pkg do
    it { should be_installed}
  end
end


describe file(stagedir) do
  it { should exist}
  it { should be_directory}
end


describe service 'chef-client' do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
