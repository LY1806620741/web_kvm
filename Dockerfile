FROM centos:7
MAINTAINER Jieshao <1806620741@qq.com>

RUN yum -y install epel-release && \
    yum -y install kvm libvirt bridge-utils virt-manager qemu-kvm-tools virt-viewer virt-v2v &&\
    yum -y install git python-pip libvirt-python libxml2-python python-websockify supervisor

RUN git clone https://github.com/retspen/webvirtmgr /webvirtmgr
WORKDIR /webvirtmgr
RUN git checkout 7f140f99f4 #v4.8.8
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt
ADD local_settings.py /webvirtmgr/webvirtmgr/local/local_settings.py
RUN /usr/bin/python /webvirtmgr/manage.py collectstatic --noinput

ADD supervisor.webvirtmgr.conf /etc/supervisord.d/webvirtmgr.ini
ADD gunicorn.conf.py /webvirtmgr/conf/gunicorn.conf.py

ADD bootstrap.sh /webvirtmgr/bootstrap.sh

RUN /webvirtmgr/bootstrap.sh

RUN yum clean

EXPOSE 8080
EXPOSE 6080
CMD ["supervisord", "-n"]
