include_recipe "riak::install_riak"
if node[:riak][:storage_backend] == "riak_kv_innostore_backend"
  include_recipe "riak::innostore"
end
include_recipe "riak::configure_riak"
include_recipe "riak::start_riak"
include_recipe "riak::join_ring"
include_recipe "riak::haproxy"
