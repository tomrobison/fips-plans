pkg_name=stunnel
pkg_origin=fips
pkg_version=5.40
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source="https://www.stunnel.org/downloads/stunnel-$pkg_version.tar.gz"
pkg_shasum=23acdb390326ffd507d90f8984ecc90e0d9993f6bd6eac1d0a642456565c45ff
pkg_deps=(
  core/bash
  core/glibc
  fips/openssl
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_svc_run="stunnel $pkg_svc_config_path/stunnel.conf"
pkg_description="Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code. With FIPS support."
pkg_upstream_url="https://www.stunnel.org/index.html"

do_prepare() {
  # Add optimization to CFLAGS to remove compiler warnings
  export CFLAGS="$CFLAGS -O"
  build_line "Setting CFLAGS=$CFLAGS"
}

do_build() {
  # Note that the configure output will always say, "checking whether to enable
  # FIPS support... no", even though it's actually enabled.
  ./configure \
    --disable-libwrap \
    --disable-systemd \
    --enable-fips \
    --with-ssl="$(pkg_path_for openssl)" \
    --prefix="$pkg_prefix"
  make
}

do_install() {
  do_default_install

  # Delete files we don't need
  for dir in etc share var; do
    rm -rf "${pkg_prefix:?}/$dir"
  done
}

do_check() {
  make check
}
