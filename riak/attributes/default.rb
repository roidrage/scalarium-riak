node[:volumes][:riak] = "/vol/riak"
node[:riak][:data_dir] = "#{node[:volumes][:riak]}/data",
node[:riak][:storage_backend] = "riak_kv_bitcask_backend"
