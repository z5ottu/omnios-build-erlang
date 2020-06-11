DOWNLOAD_SRC=https://github.com/basho/otp.git
LOCAL_SRC=otp-16

export DESTDIR=${HOME}/build/
PREFIX="/opt/erlang"

PKG_BUILD_DIR="${PREFIX}"
export CPPFLAGS = -D_XOPEN_SOURCE=600 -D__EXTENSIONS__

CONFIGURE_OPTS="--enable-smp-support --enable-dtrace --enable-threads --with-ssl=/usr/ssl --enable-dynamic-ssl-lib --enable-m64-build --disable-hipe --without-odbc --prefix=${PREFIX}"

clone:
	git clone -b 'basho-otp-16' ${DOWNLOAD_SRC} 'otp-16'

build:
	@ echo 'Print env before building'
	@ bash -c 'env'
	./fix.sh
	cd ${LOCAL_SRC}; ./otp_build autoconf
	cd ${LOCAL_SRC}; export ERL_TOP=`pwd`
	cd ${LOCAL_SRC}; ./configure "${CONFIGURE_OPTS}"
	cd ${LOCAL_SRC}; gmake -j 8
	cd ${LOCAL_SRC}; gmake install

package:
	@echo do packagey things!
	mkdir -p ${IPS_BUILD_DIR}/opt/ ${IPS_TMP_DIR}
	cp -r ${DESTDIR}/* ${IPS_BUILD_DIR}
	chmod +x ${IPS_BUILD_DIR}/opt/erlang/lib/erlang/bin/*

publish: ips-package
ifndef PKGSRVR
	echo "Need to define PKGSRVR, something like http://localhost:10000"
	exit 1
endif
	pkgsend publish -s ${PKGSRVR} -d ${IPS_BUILD_DIR} ${IPS_TMP_DIR}/pkg.pm5.final
	pkgrepo refresh -s ${PKGSRVR}

include ips.mk
