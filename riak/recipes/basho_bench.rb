# AppCloud's GCC does not include Fortran by default, so let's install GCC binaries with fortran.

execute "apt-add-repository 'deb http://<my.favorite.cran.mirror>/bin/linux/ubuntu natty/'"

execute "apt-get update"

package "r-base"

package "r-base-dev"
