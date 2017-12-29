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
  its('mode') { should cmp stagedirmode}
end
