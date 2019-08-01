# Dockerfile for building Ansible image on centos6.7, with few software as possible.
#
# Version  1.0
#
# pull base image
FROM centos:6.7

Maintainer Punit <Punitporwal07@gmail.com>

WORKDIR /software/ansible/

RUN echo "===> calling epel-release-6.8 "  && \
    rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm && \
    \
    \
#   echo "===> correcting link..."  && \
    sed -i "s/mirrorlink=https/mirrorlink=http/" /etc/yum.repos.d/epel* && \
#   sed -i "s/metalink=https/metalink=http/" /etc/yum.repos.d/epel* && \
#   \
#   \
#   echo "===> disabled unwanted repo..."  && \
#   yum-config-manager --disable ol7_UEKR5 ol7_developer_EPEL && \
#   \
#   \
#   echo "===> removed additonal repo..."  && \
#   rm -rf /etc/yum.repos.d/oracle-linux-ol7.repo && \
#   \
#   \
    echo "===> installing ANSIBLE..."  && \
    yum install ansible -y && \
    \
    \
    echo "===> cleaning yum and cache..."  && \
    yum clean all ; rm -rf /var/cache/yum && \
    \
    \
    mv /etc/ansible/hosts /etc/ansible/hosts_org

RUN echo "===> copying sample files to test ansible..."
COPY test.yml runansibletest.sh /software/ansible/
COPY hosts /etc/ansible/

RUN useradd -ms /bin/bash red && chown -R red:red /software /etc/ansible/

#ENTRYPOINT ansible --version
