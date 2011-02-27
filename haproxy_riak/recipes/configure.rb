# Yuck
#
riak_instances = []
node['utility_instances'].each do |riak|
  if riak['name'].include?("riak_")
    riak_instances << riak["hostname"]
  end
end

template "/etc/haproxy_riak.cfg" do
  owner 'root'
  group 'root'
  mode 0644
  source "haproxy.cfg.erb"
  variables({
    :backends => riak_instances,
    :haproxy_user => node[:haproxy][:username],
    :haproxy_pass => node[:haproxy][:password]
  })
end
