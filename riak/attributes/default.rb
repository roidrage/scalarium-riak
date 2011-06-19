volumes :riak => '/vol/riak'
riak :data_dir => "#{node[:volumes][:riak]}/data",
     :storage_backend => "riak_kv_bitcask_backend"
