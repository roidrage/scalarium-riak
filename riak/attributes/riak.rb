include_attribute "riak"

riak :version => "0.14.2",
     :js_vm_count => "8",
     :js_thread_stack => "16",
     :js_max_vm_mem => "8",
     :map_cache_size => 10000,
     :js_source => "/tmp/js_source",
     :cookie_name => node[:scalarium][:cluster][:name].downcase.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-').gsub(/[^[:alnum:]]+$/, ''),
     :disable_http_nagle => "false",
     :mapper_batch_size => "5",
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

