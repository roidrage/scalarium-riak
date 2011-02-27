# Pardon the dust in here. <-- sml 10-10-10..nil?

# This portion of the recipe runs on all instances, except the utility instances.  You don't want haproxy on the utility instances but you do on solo|app|app_master
if ['solo','app','app_master'].include?(node[:instance_role])
  # Uncomment the line below if you use Riak Search
  require_recipe "haproxy_riaksearch::default"

  # Uncomment this line if you use Riak K/V without Search
  # require_recipe "haproxy_riak::default"
end

# This portion of the recipe runs on only utility instances
if ['util'].include?(node[:instance_role])
  if node['name'].include?('riak_')
# Remove old version of Erlang that is NOT new enough
    package "dev-lang/erlang" do
      version "erlang-12.2.5-r1"
      action :remove
      only_if { FileTest.directory?("/var/db/pkg/dev-lang/erlang-12.2.5-r1") }
    end

# Install a version of Erlang (R130B4) provided by me.  I built the package, if you would like to see the ebuild sources make an issue.
    s3_install "dev-lang/erlang" do
      version "13.2.4"
    end

# Install python_setuptools as the version in portage is too old.

    include_recipe "riak::setuptools"

# Install Mercurial as it's required for most things with Webmachine / rebar.

    execute "easy_install mercurial" do
      action :run
      not_if { FileTest.exists?("/usr/lib/python2.5/site-packages/mercurial-1.6.4-py2.5-linux-i686.egg") }
    end

    include_recipe "riak::install_riak"
    include_recipe "riak::configure_riak"
    include_recipe "riak::start_riak"
    include_recipe "riak::join_ring"
  end
# This ends the loop for the utility instance with the name of riak_
# Remove old version of Erlang that is NOT new enough

  if node['name'].include?('riaksearch_')
    package "dev-lang/erlang" do
      version "erlang-12.2.5-r1"
      action :remove
      only_if { FileTest.directory?("/var/db/pkg/dev-lang/erlang-12.2.5-r1") }
    end

# Install a version of Erlang (R130B4) provided by me.  I built the package, if you would like to see the ebuild sources make an issue.

    s3_install "dev-lang/erlang" do
      version "13.2.4"
    end

# Install python_setuptools as its required for most things with Webmachine / rebar.

    include_recipe "riak::setuptools"

# Install Mercurial

    execute "easy_install mercurial" do
      action :run
      not_if { FileTest.exists?("/usr/lib/python2.5/site-packages/mercurial-1.6.4-py2.5-linux-i686.egg") }
    end

# We need Ant for making Search work.

    package "dev-java/ant" do
      version '1.7.0'
      action :install
    end

    include_recipe "riaksearch::default"
  end
end

