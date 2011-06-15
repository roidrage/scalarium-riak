package "haproxy" do
  action :install
end

riak_instances = []

node[:scalarium][:roles][:riak][:instances].each do |name, instance|
  riak_instances << instance[:public_dns_name]
end

template "/etc/haproxy/haproxy.cfg" do
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

template "/etc/monit/conf.d/haproxy_riak.monitrc" do
  source "haproxy_monitrc.erb"
  backup 0
  owner "root"
  group "root"
  mode 0655
  variables(
    :pidfile => "/var/run/haproxy.pid"
  )
end

template "/etc/default/haproxy" do
  source "haproxy-default.erb"
  owner "root"
  group "root"
  mode 0644
end

execute "monit reload" do
  action :run
end

ruby_block "sleep 1" do
  block do
    sleep 1
  end
end

execute "monit restart -g haproxy_riak" do
  action :run
end
