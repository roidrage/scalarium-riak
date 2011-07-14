gem_package "i18n" do
  version "0.5.0"
  action :install
end

gem_package "ripple" do
  version "0.9.5"
  action :install
end

package "libcurl3" do
  action :install
end

package "libcurl4-openssl-dev" do
  action :install
end

gem_package "curb" do
  version "0.7.15"
  action :install
end

arch = RUBY_PLATFORM.match(/64/) ? 'amd64' : 'i386'

remote_file "/tmp/#{node[:riak][:package]}_#{node[:riak][:version]}-1_#{arch}.deb" do
  source "http://downloads.basho.com/#{node[:riak][:package]}/CURRENT/#{node[:riak][:package]}_#{node[:riak][:version]}-1_#{arch}.deb"
  backup 0
  not_if { FileTest.exists?("/tmp/#{node[:riak][:package]}_#{node[:riak][:version]}-1_#{arch}.deb") }
end

dpkg_package "riak" do
  source "/tmp/#{node[:riak][:package]}_#{node[:riak][:version]}-1_#{arch}.deb"
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
