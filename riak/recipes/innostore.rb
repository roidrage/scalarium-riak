arch = RUBY_PLATFORM.match(/64/) ? 'x86_64' : 'i686'
tgz = "/tmp/innostore-#{node[:innostore][:version]}-1-deb-#{arch}.tar.gz"
remote_file tgz do
  source "http://downloads.basho.com/innostore/innostore-#{node[:innostore][:version]}/#{File.basename(tgz)}"
  backup 0
  not_if { FileTest.exists?(tgz) }
end

execute "tar xvfz #{tgz}" do
  cwd "/usr/lib/riak/lib"
end

execute "chown -R riak.riak innostore-#{node[:innostore][:version]}"

directory node[:innostore][:data_home_dir] do
  action :create
  recursive true
  owner "riak"
  group "riak"
end

