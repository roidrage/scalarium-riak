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

gem_package "curb" do
  version "0.7.15"
  action :install
end

remote_file "/tmp/riak-#{node[:riak][:version]}-1_amd64.deb" do
  source "http://downloads.basho.com/riak/CURRENT/riak-#{node[:riak][:version]}-1_amd64.deb"
  backup 0
  not_if { FileTest.exists?("/tmp/riak-#{node[:riak][:version]}-1_amd64.deb") }
end

dpkg_package do
  name "/tmp/riak-#{node[:riak][:version]}-1_amd64.deb"
end
