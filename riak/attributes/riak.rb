volumes :riak => '/vol/riak'
riak :version => "0.14.2",
     :js_vm_count => "8",
     :js_thread_stack => "16",
     :js_max_vm_mem => "8",
     :map_cache_size => 10000,
     :js_source => "/tmp/js_source",
     :data_dir => "#{node[:volumes][:riak]}/data",
     :cookie_name => node[:scalarium][:cluster][:name].downcase.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-').gsub(/[^[:alnum:]]+$/, ''),
     :disable_http_nagle => "false",
     :mapper_batch_size => "5",
     :storage_backend => "riak_kv_bitcask_backend",
     :erlang_paths => nil,
     :vnode_mr_timeout => 1000
luwak :enabled => "true"
bitcask :max_file_size => "16#80000000",
        :open_timeout => 4,
        :sync_strategy => "none",
        :merge_window => "always",
        :frag_merge_trigger => "60",
        :dead_bytes_merge_trigger => "536870912",
        :frag_threshold => "40",
        :dead_bytes_threshold => "134217728",
        :small_file_threshold => "10485760",
        :expiry_secs => "-1",
        :data_root => "#{node[:riak][:data_dir]}/bitcask"
innostore :log_buffer_size => 8388608,
          :log_files_in_group => 8,
          :log_file_size => 1073741824, # 1 GB default
          :flush_log_at_trx_commit => 1,
          :data_home_dir => "#{node[:riak][:data_dir]}/innodb",
          :log_group_home_dir => "#{node[:riak][:data_dir]}/innodb",
          :buffer_pool_size => 2147483648,
          :version => "1.0.2",
          :flush_method => "O_DIRECT"
