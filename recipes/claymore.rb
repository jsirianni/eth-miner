# Make miner install directory
directory node[:miner][:claymore][:inst_dir] do
  owner node[:miner][:user]
  group node[:miner][:user]
  mode '0700'
  recursive true
  action :create
end

# Download claymore
remote_file "#{node[:miner][:stage][:dir]}/#{node[:miner][:claymore][:archive]}" do
  user     node[:miner][:user]
  group    node[:miner][:user]
  source   node[:miner][:claymore][:source]
  not_if   { ::File.exist?("#{node[:miner][:instmedia]}/#{node[:miner][:claymore][:archive]}") }
end

# Extract claymore
bash 'extract claymore' do
  user     node[:miner][:user]
  group    node[:miner][:user]
  cwd      node[:miner][:instmedia]
  code     "tar -xvf #{node[:miner][:claymore][:archive]} -C #{node[:miner][:claymore][:inst_dir]}"
  not_if   { ::File.exist?("#{node[:miner][:claymore][:executable]}") }
end

# Place startup script
template "#{node[:miner][:claymore][:dir]}/mine.sh" do
  user     node[:miner][:user]
  group    node[:miner][:user]
  source   node[:miner][:claymore][:start_script]
  mode     node[:miner][:claymore][:mode]
  action   :create
end

# Set chmod on claymore executable
#bash 'chmod u+s' do
#  user  'root'
#  group 'root'
#  cwd   node[:miner][:claymore_dir]
#  code  "chmod u+s ethdcrminer64"
#end


# Place miner startup script
#template "/home/#{node[:miner][:user]}/miner_launcher.sh" do
#  user     node[:miner][:user]
#  group    node[:miner][:user]
#  source   'miner_launcher.sh.erb'
#  mode     '0755'
#  action   :create
#end

# Place rc.local startup script
#template '/etc/rc.local' do
#  user    'root'
#  group   'root'
#  source  'rc.local.erb'
#  mode    '0755'
#  action  :create
#end

# Place .bashrc startup script
#template "#{node[:miner][:user_home]}/.bashrc" do
#  user    node[:miner][:user]
#  group   node[:miner][:user]
#  source  '.bashrc.erb'
#  mode    '0644'
#  action  :create
#end
