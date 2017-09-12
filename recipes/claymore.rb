# Make miner install directory
directory node[:miner][:miner_install_dir] do
  owner node[:team][:admin]
  group node[:team][:admin]
  mode '0755'
  recursive true
  action :create
end

# Download claymore
remote_file "#{node[:miner][:instmedia]}/#{node[:miner][:claymore_archive]}" do
  user     node[:team][:admin]
  group    node[:team][:admin]
  source   node[:miner][:claymore_source]
  not_if   { ::File.exist?("#{node[:miner][:instmedia]}/#{node[:miner][:claymore_archive]}") }
end

# Extract claymore
bash 'extract claymore' do
  user     'root'
  group    'root'
  cwd      node[:miner][:instmedia]
  code     "tar -xvf #{node[:miner][:claymore_archive]} -C #{node[:miner][:claymore_dir]}"
  not_if   { ::File.exist?("#{node[:miner][:claymore_executable]}") }
end

# Place miner script
template "#{node[:miner][:claymore_dir]}/mine.sh" do
  user     'root'
  group    'root'
  source   'miner.sh.erb'
  mode     '0755'
  action   :create
end

# Set chmod on claymore executable
bash 'chmod u+s' do
  user  'root'
  group 'root'
  cwd   node[:miner][:claymore_dir]
  code  "chmod u+s ethdcrminer64"
end


# Place miner startup script
template "/home/#{node[:team][:admin]}/miner_launcher.sh" do
  user     node[:team][:admin]
  group    node[:team][:admin]
  source   'miner_launcher.sh.erb'
  mode     '0755'
  action   :create
end

# Place rc.local startup script
template '/etc/rc.local' do
  user    'root'
  group   'root'
  source  'rc.local.erb'
  mode    '0755'
  action  :create
end

# Place .bashrc startup script
template "#{node[:team][:admin_home]}/.bashrc" do
  user    node[:team][:admin]
  group   node[:team][:admin]
  source  '.bashrc.erb'
  mode    '0644'
  action  :create
end
