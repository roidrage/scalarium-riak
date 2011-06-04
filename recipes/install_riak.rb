# Installer stuff here
#

gem_package "i18n" do
  version "0.5.0"
  action :install
end

gem_package "ripple" do
  version "0.9.4"
  action :install
end

gem_package "curb" do
  version "0.7.15"
  action :install
end

arch = RUBY_PLATFORM.match(/64/) ? 'amd64' : 'i386'

remote_file "/tmp/riak-#{node[:riak][:version]}-1_#{arch}.deb" do
  source "http://downloads.basho.com/riak/CURRENT/riak-#{node[:riak][:version]}-1_#{arch}.deb"
  backup 0
  not_if { FileTest.exists?("/tmp/riak-#{node[:riak][:version]}-1_#{arch}.deb") }
end

dpkg_package do
  name "/tmp/riak-#{node[:riak][:version]}-1_#{arch}.deb"
end
