# Ring Related code here.
#
riak_instances = []

node[:scalarium][:roles][:riak][:instances].each do |name, instance|
  riak_instances << instance[:public_dns_name]
end

Chef::Log.info("Instances: #{riak_instances.size}")

if riak_instances.size == 0 or (riak_instances.size == 1 and riak_instances.include?(node[:scalarium][:instance][:public_dns_name]))
  Chef::Log.info "I'm the only instance in this cluster. No need to join. Forever alone."
else
  srand
  riak_instances.delete(node[:scalarium][:instance][:hostname])
  riak_hostname = riak_instances[rand(riak_instances.size)]

  Chef::Log.info "Joining cluster at node #{riak_hostname}"
  execute "riak-admin join riak@#{riak_hostname}" do
    action :run
  end
end
