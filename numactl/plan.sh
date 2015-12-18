pkg_name=numactl
pkg_derivation=chef
pkg_version=2.0.10
pkg_license=('GPLv2', 'LGPL2.1')
pkg_source=https://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=c52df9043bbf6edd4d31b1f9f2b2ca6a71cec7932bf4dc181fb7d6fda45b86f8
pkg_gpg_key=3853DA6B
pkg_deps=(chef/glibc)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_binary_path=(bin)

do_build() {
  ./autogen.sh
  ./configure --prefix=$pkg_prefix
}

