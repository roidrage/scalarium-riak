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

remote_file "/mnt/src/riak_search-0.13.0.tar.gz" do
  source "http://downloads.basho.com/riak-search/riak-search-0.13/riak_search-0.13.0.tar.gz"
  backup 0
  not_if { FileTest.exists?("/mnt/src/riak_search-0.13.0.tar.gz") }
end

execute "untar riak" do
  command "cd /mnt/src;tar zxf riak_search-0.13.0.tar.gz"
  not_if { FileTest.directory?("/mnt/src/riak_search-0.13.0") }
end

execute "make all rel" do
  command "cd /mnt/src/riak_search-0.13.0;make all rel && cp -prv rel/riaksearch /data/riaksearch"
  not_if { FileTest.exists?("/data/riaksearch/bin/riaksearch") }
end
