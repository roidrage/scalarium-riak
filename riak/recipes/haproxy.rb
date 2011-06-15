package "haproxy" do
  action :install
end

riak_instances = []

node[:scalarium][:roles][:riak][:instances].each do |name, instance|
  riak_instances << instance[:public_dns_name]
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

template "/etc/monit.d/haproxy_riak.monitrc" do
  source "haproxy_monitrc.erb"
  backup 0
  owner "root"
  group "root"
  mode 0655
  variables(
    :pidfile => "/var/run/haproxy_riak.pid"
  )
end

execute "monit reload" do
  action :run
end
