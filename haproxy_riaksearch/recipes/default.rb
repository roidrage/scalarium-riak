if ['solo','app_master', 'app'].include?(node[:instance_role])
  include_recipe "haproxy_riaksearch::configure"

  enable_package 'net-proxy/haproxy' do
    version '1.4.8'
  end

  package "net-proxy/haproxy" do
    version '1.4.8'
    action :install
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
end
