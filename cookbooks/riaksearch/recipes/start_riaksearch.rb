execute "cd /data/riaksearch;bin/riaksearch start && sleep 5;true" do
  action :run
#  not_if { "ps aux | grep riak" }
end
