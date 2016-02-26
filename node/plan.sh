pkg_name=node
pkg_origin=chef
pkg_version=4.2.6
pkg_license=('MIT')
pkg_maintainer="The Bldr Maintainers <bldr@chef.io>"
pkg_source=https://nodejs.org/dist/v${pkg_version}/${pkg_name}-v${pkg_version}.tar.gz
# the archive contains a 'v' version # prefix, but the default value of
# pkg_version is node-4.2.6 (without the v). This tweak makes bldr-build happy
pkg_dirname=node-v${pkg_version}
pkg_shasum=ea5e357db8817052b17496d607c719d809ed1383e8fcf7c8ffc5214e705aefdd
pkg_gpg_key=3853DA6B
pkg_deps=(chef/glibc chef/gcc-libs)
pkg_build_deps=(chef/python2 chef/gcc chef/make chef/coreutils)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_binary_path=(bin)
pkg_interpreters=(bin/node)

do_build() {
    fix_interpreter configure chef/coreutils bin/env

    # use --without-snapshot, because https://github.com/nodejs/node/issues/4212
    ./configure --prefix=${pkg_prefix} --without-snapshot && make && make install
}
