FROM centos:7
# 设置编码
ENV LANG en_US.UTF-8
# 同步时间
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
    sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
RUN curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
RUN yum makecache

WORKDIR /usr/src/app
VOLUME /usr/src/app

ADD ./build.sh /build.sh
RUN sed -i 's/\r//' /build.sh && /bin/bash /build.sh

ADD ./requirements.txt /requirements.txt

RUN pip3 install --upgrade pip --index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip3 install -r /requirements.txt

USER root