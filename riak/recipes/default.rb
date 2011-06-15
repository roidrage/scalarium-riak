include_recipe "riak::install_riak"
include_recipe "riak::configure_riak"
include_recipe "riak::start_riak"
include_recipe "riak::join_ring"
