if node[:riak][:search_enabled]
  service "riaksearch" do
    action :start
  end
else
  service "riak" do
    action :start
  end
end
