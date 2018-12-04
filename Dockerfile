FROM centos:7
MAINTAINER Jieshao <1806620741@qq.com>

RUN yum -y install epel-release -y && \
    yum -y install git python-pip libvirt-python libxml2-python python-websockify supervisor -y

RUN git clone https://github.com/retspen/webvirtmgr /webvirtmgr
WORKDIR /webvirtmgr
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple numpy
ADD local_settings.py /webvirtmgr/webvirtmgr/local/local_settings.py
RUN /usr/bin/python /webvirtmgr/manage.py collectstatic --noinput

ADD supervisor.webvirtmgr.conf /etc/supervisord.d/webvirtmgr.ini
ADD gunicorn.conf.py /webvirtmgr/conf/gunicorn.conf.py

ADD bootstrap.sh /webvirtmgr/bootstrap.sh

RUN /bin/sh /webvirtmgr/bootstrap.sh

RUN yum clean all

EXPOSE 8080
EXPOSE 6080
CMD ["supervisord", "-n"]
