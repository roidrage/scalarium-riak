# Installer stuff here
#

gem_package "ripple" do
  version "0.9.0.beta"
  action :install
end

gem_package "curb" do
  version "0.7.12"
  action :install
end

remote_file "/mnt/src/riak-0.14.1.tar.gz" do
  source "http://downloads.basho.com/riak/CURRENT/riak-0.14.1.tar.gz"
  backup 0
  not_if { FileTest.exists?("/mnt/src/riak-0.14.1.tar.gz") }
end

execute "untar riak" do
  command "cd /mnt/src;tar zxf riak-0.14.1.tar.gz"
  not_if { FileTest.directory?("/mnt/src/riak-0.14.1") }
end

execute "make all rel" do
  command "cd /mnt/src/riak-0.14.1;make all rel && cp -prv rel/riak /data/riak"
  not_if { FileTest.exists?("/data/riak/bin/riak") }
end
