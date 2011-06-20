arch = RUBY_PLATFORM.match(/64/) ? 'amd64' : 'i386'

remote_file "/tmp/innostore_#{node[:innostore][:version]}-2_#{arch}.deb" do
  source "http://downloads.basho.com/innostore/innostore-#{node[:innostore][:version]}/innostore_#{node[:innostore][:version]}-2_#{arch}.deb"
  backup 0
  not_if { FileTest.exists?("/tmp/riak_#{node[:innostore][:version]}-2_#{arch}.deb") }
end

dpkg_package "innostore" do
  source "/tmp/innostore_#{node[:innostore][:version]}-2_#{arch}.deb"
end

directory node[:innostore][:data_home_dir] do
  action :create
  recursive true
  owner "riak"
  group "riak"
end

