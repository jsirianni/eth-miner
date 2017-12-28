amdinstaller = '/tmp/instmedia/amdgpu-pro-install'
checkdrivercmd = 'dpkg -l amdgpu-pro'

describe file(amdinstaller) do
  it { should exist }
end


describe command(checkdrivercmd) do
  its('matcher') { should_not eq "no packages found matching amdgpu-pro\n"}
end
