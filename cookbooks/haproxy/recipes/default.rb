if ['app_master', 'app'].include?(node[:instance_role])
  include_recipe "haproxy::configure"

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
end
