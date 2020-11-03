#!/bin/bash

masscan_ver=1.0.5

function error_exit
{
  echo -e "\033[41;30m [ERROR]"$1"\033[0m" 1>&2
  exit 1
}

function install_deps()
{
  yum -y install wget curl make gcc \
    libtiff-devel libffi-devel libjpeg-devel \
    gcc flex bison libpcap-devel;
  yum -y install python3 python3-pip python3-devel ;
  # TODO install nmap
  rpm -vhU https://nmap.org/dist/nmap-7.80-1.x86_64.rpm ;
}


function build_masscan()
{
  wget -c -N https://github.com/robertdavidgraham/masscan/archive/${masscan_ver}.tar.gz && \
    tar xf ${masscan_ver}.tar.gz && cd masscan-${masscan_ver} && \
    sed -i 's/clang/gcc/g' Makefile && make
}

build_masscan || error_exit 'install masscan error' ;