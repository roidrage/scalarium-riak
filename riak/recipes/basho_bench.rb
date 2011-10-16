# AppCloud's GCC does not include Fortran by default, so let's install GCC binaries with fortran.

execute "apt-add-repository 'deb http://ftp.heanet.ie/mirrors/cran.r-project.org/bin/linux/ubuntu/ natty/'"

execute "apt-get update"

package "r-base" do
  action :install
  options "--force-yes"
end

package "r-base-dev" do
  action :install
  options "--force-yes"
end
