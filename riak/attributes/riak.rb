default[:volumes][:riak] = '/vol/riak'
default[:riak][:version] = "1.0.0"
default[:riak][:package] = "riak"
default[:riak][:mapred_system] = "pipe"
default[:riak][:js_vm_count] = "8"
default[:riak][:js_thread_stack] = "16"
default[:riak][:js_max_vm_mem] = "8"
default[:riak][:map_cache_size] = 10000
default[:riak][:js_source] = "/tmp/js_source"
default[:riak][:data_dir] = "#{node[:volumes][:riak]}/data"
default[:riak][:cookie_name] = node[:scalarium][:cluster][:name].downcase.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-').gsub(/[^[:alnum:]]+$/, '')
default[:riak][:disable_http_nagle] = "false"
default[:riak][:mapper_batch_size] = "5"
default[:riak][:storage_backend] = "riak_kv_bitcask_backend"
default[:riak][:erlang_paths] = nil
default[:riak][:vnode_mr_timeout] = 1000
default[:riak][:ring_creation_size] = 64

if node[:scalarium][:instance][:public_dns_name].nil? or node[:scalarium][:instance][:public_dns_name].empty?
  Chef::Log.info("Scalarium host name is empty, using EC2 meta data: #{node[:ec2][:public_hostname]}")
  default[:riak][:node_name] = node[:ec2][:public_hostname]
else
  default[:riak][:node_name] = node[:scalarium][:instance][:public_dns_name]
end

default[:luwak][:enabled] = "true"

default[:bitcask][:max_file_size] = "16#80000000"
default[:bitcask][:open_timeout] = 4
default[:bitcask][:sync_strategy] = "none"
default[:bitcask][:merge_window] = "always"
default[:bitcask][:frag_merge_trigger] = "60"
default[:bitcask][:dead_bytes_merge_trigger] = "536870912"
default[:bitcask][:frag_threshold] = "40"
default[:bitcask][:dead_bytes_threshold] = "134217728"
default[:bitcask][:small_file_threshold] = "10485760"
default[:bitcask][:expiry_secs] = "-1"
default[:bitcask][:data_root] = "#{node[:riak][:data_dir]}/bitcask"

default[:innostore][:log_buffer_size] = 8388608
default[:innostore][:log_files_in_group] = 8
default[:innostore][:log_file_size] = 385875968 # 368 MB default
default[:innostore][:flush_log_at_trx_commit] = 1
default[:innostore][:data_home_dir] = "#{node[:riak][:data_dir]}/innodb"
default[:innostore][:log_group_home_dir] = "#{node[:riak][:data_dir]}/innodb"
default[:innostore][:buffer_pool_size] = 2147483648
default[:innostore][:version] = "1.0.3"
default[:innostore][:flush_method] = "O_DIRECT"

default[:leveldb][:data_root] = "#{node[:riak][:data_dir]}/leveldb"
default[:leveldb][:write_buffer_size] = 4194304
default[:leveldb][:max_open_files] = 20
default[:leveldb][:block_size] = 4096
default[:leveldb][:block_restart_interval] = 16
default[:leveldb][:cache_size] = 8388608
default[:leveldb][:sync] = true
default[:leveldb][:verify_checksums] = true

default[:riak][:search][:data_root] = "#{node[:riak][:data_dir]}/merge_index"
default[:riak][:search][:max_search_results] = 100000
default[:riak][:search][:solr_name] = "solr"
default[:riak][:search][:default_schema] = "search"
default[:riak][:search][:search_backend] = "merge_index_backend"

default[:riak][:search][:buffer_rollover_size] = 1048576
default[:riak][:search][:buffer_delayed_write_size] = 524288
default[:riak][:search][:buffer_delayed_write_ms] = 2000
default[:riak][:search][:max_compact_segments] = 20
default[:riak][:search][:fold_batch_size] = 100
default[:riak][:search][:segment_query_read_ahead_size] = 65536
default[:riak][:search][:segment_compaction_read_ahead_size] = 5242880
default[:riak][:search][:segment_file_buffer_size] = 20971520
default[:riak][:search][:segment_delayed_write_size] = 20971520
default[:riak][:search][:segment_delayed_write_ms] = 10000
default[:riak][:search][:segment_full_read_size] = 5242880
default[:riak][:search][:segment_block_size] = 32767
default[:riak][:search][:segment_values_staging_size] = 1000
default[:riak][:search][:segment_values_compression_threshold] = 0
default[:riak][:search][:segment_values_compression_level] = 1
