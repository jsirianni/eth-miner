amdinstaller = '/tmp/instmedia/amdgpu-pro-17.10-414273/amdgpu-pro-install'
checkdrivercmd = 'dpkg -l amdgpu-pro'


describe file(amdinstaller) do
  it { should exist }
end


describe command(checkdrivercmd) do
  its('exit_status') { should eq 0 }
end
