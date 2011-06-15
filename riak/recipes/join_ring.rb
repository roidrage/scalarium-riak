# Ring Related code here.
#
riak_instances = []

node[:scalarium][:roles][:riak][:instances].each do |name, instance|
  riak_instances << instance[:public_dns_name]
end

if riak_instances.empty? or riak_instances.size == 1 and riak_instances.include?(node[:scalarium][:instance][:public_dns_name])
  Chef::Log.info "I'm the only instance in this cluster. No need to join. Forever alone."
else
  srand
  riak_instances.delete(node[:scalarium][:instance][:hostname])
  riak_hostname = riak_instances[rand(riak_instances.size)]

  ruby_block do
    block do
      ring_ready = false
      while not ring_ready
        ring_ready = system('riak-admin ringready')
        sleep 5 if not ring_ready
      end
    end
  end

  execute "riak-admin join riak@#{riak_hostname}" do
    action :run
  end
end
