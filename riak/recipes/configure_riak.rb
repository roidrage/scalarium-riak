# Configure stuff goes here
#

template "/data/riak/etc/vm.args" do
  source "vm.args.erb"
  owner node[:owner_name]
  group node[:owner_name]
  mode 0655
  backup 0
end

template "/data/riak/etc/app.config" do
  source "app.config.erb"
  backup 0
  mode 0655
  owner node[:owner_name]
  group node[:owner_name]
end