default[:volumes][:riak] = '/vol/riak'
default[:riak][:version] = "0.14.2"
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
default[:innostore][:log_file_size] = 536870912 # 1 GB default
default[:innostore][:flush_log_at_trx_commit] = 1
default[:innostore][:data_home_dir] = "#{node[:riak][:data_dir]}/innodb"
default[:innostore][:log_group_home_dir] = "#{node[:riak][:data_dir]}/innodb"
default[:innostore][:buffer_pool_size] = 2147483648
default[:innostore][:version] = "1.0.2"
default[:innostore][:flush_method] = "O_DIRECT"
