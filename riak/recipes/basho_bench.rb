# AppCloud's GCC does not include Fortran by default, so let's install GCC binaries with fortran.

execute "apt-add-repository 'deb http://ftp.heanet.ie/mirrors/cran.r-project.org/bin/linux/ubuntu/ natty/'"

execute "apt-get update"

%w{r-base r-base-dev r-cran-getopt}.each do |package|
  package package do
    action :install
    options "--force-yes"
  end
end
