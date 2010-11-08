# Installer stuff here
#

gem_package "ripple" do
  version "0.8.2" 
  action :install
end

gem_package "curb" do
  version "0.7.8"
  action :install
end

remote_file "/mnt/src/riak-0.13.0.tar.gz" do
  source "http://downloads.basho.com/riak/riak-0.13/riak-0.13.0.tar.gz"
  backup 0
  not_if { FileTest.exists?("/mnt/src/riak-0.13.0.tar.gz") }
end

execute "untar riak" do
  command "cd /mnt/src;tar zxf riak-0.13.0.tar.gz"
  not_if { FileTest.directory?("/mnt/src/riak-0.13.0") }
end

execute "make all rel" do
  command "cd /mnt/src/riak-0.13.0;make all rel && cp -prv rel/riak /data/riak"
  not_if { FileTest.exists?("/data/riak/bin/riak") }
end
