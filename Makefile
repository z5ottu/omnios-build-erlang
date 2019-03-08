PROJECT=erlang
VERSION=21.2.7
SAFE_VERSION=21.2.7
PROJECT_NAME=${PROJECT}-${SAFE_VERSION}
PROJECT_VERSION=${VERSION}
DOWNLOAD_SRC=https://github.com/erlang/otp/archive/OTP-${VERSION}.tar.gz
LOCAL_SRC_TAR=src.tar.gz2
LOCAL_SRC=otp-OTP-${VERSION}

USERNAME=erlang
GROUPNAME=erlang

PREFIX="${HOME}/build/erlang-${VERSION}"
PKG_BUILD_DIR="${PREFIX}"

CONFIGURE_OPTS="--enable-smp-support --enable-dtrace --enable-threads --with-ssl=/usr --enable-dynamic-ssl-lib --enable-m64-build"


clone:
	curl -fvL ${DOWNLOAD_SRC} -o ${LOCAL_SRC_TAR}
	tar -xvf ${LOCAL_SRC_TAR}
	ls

build:
	@ echo 'Print env before building'
	@ bash -c 'env'
	cd ${LOCAL_SRC}; ./otp_build autoconf
	cd ${LOCAL_SRC}; export ERL_TOP=`pwd`
	cd ${LOCAL_SRC}; ./configure "${CONFIGURE_OPTS}"
	cd ${LOCAL_SRC}; make -j 8
	cd ${LOCAL_SRC}; make install-world

package:
	@echo do packagey things!
	mkdir -p ${IPS_BUILD_DIR}/opt/ ${IPS_TMP_DIR}
	cp -r ${PREFIX} ${IPS_BUILD_DIR}/opt

	# SMF
	mkdir -p ${IPS_BUILD_DIR}/lib/svc/manifest/database/
	mkdir -p ${IPS_BUILD_DIR}/lib/svc/method/
	cp smf.xml ${IPS_BUILD_DIR}/lib/svc/manifest/database/${PROJECT_NAME}.xml
	cp method ${IPS_BUILD_DIR}/lib/svc/method/${PROJECT_NAME}

publish: ips-package
ifndef PKGSRVR
	echo "Need to define PKGSRVR, something like http://localhost:10000"
	exit 1
endif
	pkgsend publish -s ${PKGSRVR} -d ${IPS_BUILD_DIR} ${IPS_TMP_DIR}/pkg.pm5.final
	pkgrepo refresh -s ${PKGSRVR}

include ips.mk
