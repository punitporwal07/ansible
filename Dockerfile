FROM centos:6.7

Maintainer Punit <Punitporwal07@gmail.com>

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum install ansible -y

COPY test.yml /software/ansible/
COPY runansibletest.sh /software/ansible/
RUN mv /etc/ansible/hosts /etc/ansible/hosts_org
COPY hosts /etc/ansible/
RUN useradd -ms /bin/bash red && chown -R red:red /software/
WORKDIR /software/ansible/

#ENTRYPOINT ansible --version
