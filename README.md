# omnios-build-erlang
Omnios Build Scripts for Erlang/OTP Basho OTP R16

https://github.com/basho/otp/tree/OTP_R16B02_basho10

Tested on Omniosce r151034

UPDATE: crypto works !!! :)

# PRE
```
pkg install autoconf
pkg install gcc8
pkg install gnu-make
pkg install clang-100
pkg install git
pkg install top
```

# solve the “configured for kerberos but no krb5.h found” problem
```
pkg install kerberos-5
mkdir /usr/krb5
ln -s /usr/include/kerberosv5 /usr/krb5/include
ln -s /usr/lib/krb5 /usr/krb5/lib
```

# compile openssl-0.9.7
```
git clone -b OpenSSL_0_9_7-stable https://github.com/openssl/openssl.git
cd openssl
./Configure shared --with-krb5-dir=/usr/krb5 --openssldir=/usr/ssh-0.9.7 solaris64-x86_64-gcc
gmake
gmake install
```


# BUILD and INSTALL
```
gmake
gmake build
```
