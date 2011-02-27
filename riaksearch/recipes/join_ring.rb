# Ring Related code here.
#

case node[:name]
when "riaksearch_0"
  Chef::Log.info "I am riaksearch_0 at #{@node[:ec2][:local_hostname]}"
else
  riak_utility_instance = node['utility_instances'].find {|riak| riak["name"] =~ /riaksearch_0/ }
  riak_hostname = riak_utility_instance['private_hostname'] || riak_utility_instance['hostname']


# dirty hack below cover your eyes, please pardon.
#Chef::Log.info "I am #{node[:name]} and my /stats is #{riak_stats}"
#ring_members = riak_stats["ring_members"]

  execute "cd /data/riaksearch;bin/riaksearch-admin join riak@#{riak_hostname}" do
      action :run
  end
end
