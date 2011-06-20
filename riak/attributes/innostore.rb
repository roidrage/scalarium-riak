innostore :log_buffer_size => 8388608,
          :log_files_in_group => 8,
          :log_file_size => 1073741824, # 1 GB default
          :flush_log_at_trx_commit => 1,
          :data_home_dir => "#{node[:riak][:data_dir]}/innodb",
          :log_group_home_dir => "#{node[:riak][:data_dir]}/innodb",
          :buffer_pool_size => 2147483648,
          :version => "1.0.2",
          :flush_method => "O_DIRECT"