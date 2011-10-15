arch = RUBY_PLATFORM.match(/64/) ? 'amd64' : 'i386'

remote_file "/tmp/#{node[:riak][:package]}_#{node[:riak][:version]}-1_#{arch}.deb" do
  source "http://downloads.basho.com/#{node[:riak][:package]}/riak-#{node[:riak][:version]}/#{node[:riak][:package]}_#{node[:riak][:version]}-1_#{arch}.deb"
  backup 0
  not_if { FileTest.exists?("/tmp/#{node[:riak][:package]}_#{node[:riak][:version]}-1_#{arch}.deb") }
end

dpkg_package "riak" do
  source "/tmp/#{node[:riak][:package]}_#{node[:riak][:version]}-1_#{arch}.deb"
end

directory "#{node[:riak][:data_dir]}" do
  action :create
  recursive true
  owner "riak"
  group "riak"
end

directory "#{node[:riak][:data_dir]}/ring" do
  action :create
  recursive true
  owner "riak"
  group "riak"
end

directory "#{node[:bitcask][:data_root]}" do
  action :create
  recursive true
  owner "riak"
  group "riak"
end

directory "#{node[:leveldb][:data_root]}" do
  action :create
  recursive true
  owner "riak"
  group "riak"
end

if node[:riak][:search_enabled]
  directory "#{node[:riak][:data_dir]}/merge_index" do
    action :create
    recursive true
    owner "riak"
    group "riak"
  end
end

directory "/usr/lib/riak/data/mr_queue" do
  action :create
  recursive true
  owner "riak"
  group "riak"
end
