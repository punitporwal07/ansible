# Dockerfile for building Ansible image on centos6.7, with few software as possible.
#
# Version  1.0
#
# pull base image
FROM centos:6.7

Maintainer Punit <Punitporwal07@gmail.com>

  RUN echo "===> calling epel-release-6.8..."  && \
      rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm && \
      \
      \
      echo "===> installing ANSIBLE..."  && \
      yum install ansible -y

RUN echo "===> copying sample files to test ansible..."
COPY test.yml /software/ansible/ && \
     runansibletest.sh /software/ansible/
     
RUN mv /etc/ansible/hosts /etc/ansible/hosts_org
COPY hosts /etc/ansible/
RUN useradd -ms /bin/bash red && chown -R red:red /software/
WORKDIR /software/ansible/

#ENTRYPOINT ansible --version
