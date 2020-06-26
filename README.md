# omnios-build-erlang
Omnios Build Scripts for Erlang/OTP Basho OTP R16

https://github.com/basho/otp/tree/OTP_R16B02_basho10

Tested on Omniosce r151030

compile openssl-0.9.7
```bash
./Configure shared --with-krb5-lib=/usr/lib/krb5 --with-krb5-include=/usr/include/kerberosv5 --openssldir=/usr/ssh-0.9.7 solaris64-x86_64-gcc
```

UPDATE: crypto app not works !!! :(

# PRE
```bash
pkg install autoconf@2.69-151030.0
pkg install gcc8@8.3.0-151030.0
pkg install gnu-make@4.2.1-151030.0
pkg install clang-100@10.0.0-151030.0
pkg install git@2.21.0-151030
pkg install top@3.7-151030.0
pkg install pkg:/library/security/openssl@1.1.1.7-151030.0
pkg install kerberos-5@0.5.11-151030.0
pkg install gnu-binutils@2.32-151030.0
```

solve the “configured for kerberos but no krb5.h found” problem
```bash
ln -s /usr/include/kerberosv5 /usr/ssl/include/kerberos
```

# BUILD and INSTALL
```bash
gmake
gmake build
```
