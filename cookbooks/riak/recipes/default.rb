# Pardon the dust in here. <-- sml 10-10-10
require_recipe "haproxy"
if ['util'].include?(node[:instance_role])
  if node['name'].include?('riak_')
    package "dev-lang/erlang" do
      version "erlang-12.2.5-r1"
      action :remove
      only_if { FileTest.directory?("/var/db/pkg/dev-lang/erlang-12.2.5-r1") }
    end

    s3_install "dev-lang/erlang" do
      version "13.2.4"
    end

    require_recipe "riak::setuptools"

    execute "easy_install mercurial" do
      action :run
      not_if { FileTest.exists?("/usr/lib/python2.5/site-packages/mercurial-1.6.4-py2.5-linux-i686.egg") }
    end
    require_recipe "riak::install_riak"
    require_recipe "riak::configure_riak"
    require_recipe "riak::start_riak"
    require_recipe "riak::join_ring"
  end
  if node['name'].include?('riaksearch_')
    package "dev-lang/erlang" do
      version "erlang-12.2.5-r1"
      action :remove
      only_if { FileTest.directory?("/var/db/pkg/dev-lang/erlang-12.2.5-r1") }
    end

    s3_install "dev-lang/erlang" do
      version "13.2.4"
    end

    require_recipe "riak::setuptools"

    execute "easy_install mercurial" do
      action :run
      not_if { FileTest.exists?("/usr/lib/python2.5/site-packages/mercurial-1.6.4-py2.5-linux-i686.egg") }
    end
    
    package "dev-java/ant" do
      version '1.7.0'
      action :install
    end

    require_recipe "riaksearch::default"
  end
end

