# Installer stuff here
#

gem_package "i18n" do
  version "0.5.0"
  action :install
end

gem_package "ripple" do
  version "0.9.3"
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

remote_file "/tmp/riak_#{node[:riak][:version]}-1_#{arch}.deb" do
  source "http://downloads.basho.com/riak/CURRENT/riak_#{node[:riak][:version]}-1_#{arch}.deb"
  backup 0
  not_if { FileTest.exists?("/tmp/riak_#{node[:riak][:version]}-1_#{arch}.deb") }
end

directory "#{node[:riak][:data_dir]}/ring" do
  action :create
  recursive true
end

directory "#{node[:bitcask][:data_root]}" do
  action :create
  recursive true
end

dpkg_package "riak" do
  source "/tmp/riak_#{node[:riak][:version]}-1_#{arch}.deb"
end
