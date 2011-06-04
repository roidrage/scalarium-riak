# Ring Related code here.
#
case node['name']
when "riak_0"
#I shouldn't do squat here, i'm on the master node.
Chef::Log.info "I am riak_0 at #{node[:ec2][:public_hostname]}"
else
  riak_utility_instance = node['utility_instances'].find {|riak| riak["name"] =~ /riak_0/ }
  riak_hostname = riak_utility_instance['private_hostname'] || riak_utility_instance['hostname']

  execute "riak-admin join riak@#{riak_hostname}" do
    action :run
  end
end
