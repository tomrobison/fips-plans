pkg_origin=fips
pkg_name=openssl-fips
pkg_version=2.0.12
pkg_maintainer="Tom Robison <thomas.robison@gmail.com>"
pkg_license=()
pkg_source=https://openssl.org/source/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=ab5af8f4c542ce3fae31fbd99b029fdc37da5e655191f3c4bfdaa8b0d6dc10b7
pkg_deps=(core/glibc)
pkg_build_deps=(core/coreutils core/gcc core/make core/perl)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  do_default_prepare

  # Purge the codebase (mostly tests) of the hardcoded reliance on `/bin/rm`.
  grep -lr '/bin/rm' . | while read f; do
    sed -e 's,/bin/rm,rm,g' -i "$f"
  done
}

do_build() {
  ./config no-asm --prefix=$pkg_prefix
  make
}
