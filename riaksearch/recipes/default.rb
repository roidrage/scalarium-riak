# Pardon the dust in here. <-- sml 10-10-10
if ['util'].include?(node[:instance_role])
  if node['name'].include?('riaksearch_')
    package "dev-lang/erlang" do
      version "erlang-12.2.5-r1"
      action :remove
      only_if { FileTest.directory?("/var/db/pkg/dev-lang/erlang-12.2.5-r1") }
    end

    s3_install "dev-lang/erlang" do
      version "13.2.4"
    end

    require_recipe "riaksearch::setuptools"

    execute "easy_install mercurial" do
      action :run
      not_if { FileTest.exists?("/usr/lib/python2.5/site-packages/mercurial-1.6.4-py2.5-linux-i686.egg") }
    end
    
    package "dev-java/ant" do
      version '1.7.0'
      action :install
    end

    require_recipe "riaksearch::install_riaksearch"
    require_recipe "riaksearch::configure_riaksearch"
    require_recipe "riaksearch::start_riaksearch"
    require_recipe "riaksearch::join_ring"
  end
end
