FROM centos:7
#FROM centos:centos6.9

# It is not important
#RUN yum update -y
RUN yum install -y openssh-server openssh-clients vim

RUN     ssh-keygen -q -b 4096 -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key && \
        ssh-keygen -q -b 1024 -N '' -t dsa -f /etc/ssh/ssh_host_dsa_key && \
        ssh-keygen -q -b 521 -N '' -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
#&& \
#		ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''

RUN echo /usr/sbin/sshd >> /root/.bashrc && source /root/.bashrc

RUN     sed -i \
        -e 's~^#PermitRootLogin yes~PermitRootLogin yes~g' \
        /etc/ssh/sshd_config

CMD service sshd restart
EXPOSE 22

# Need package
RUN yum install -y net-tools sudo gdb
RUN yum install -y git wget tar java-1.6.0-openjdk.x86_64 java-1.6.0-openjdk-devel.x86_64 dos2unix
RUN yum install -y gcc-4.4.7 gcc-c++ libtool-2.2.6

RUN echo 'root:1234' | chpasswd

RUN useradd ctp
RUN echo 'ctp:1234' | chpasswd

RUN useradd ha_repl_01
RUN echo 'ha_repl_01:1234' | chpasswd

WORKDIR /home/ctp

# ctp
CMD chown -R ctp ctp_config
CMD chgrp -R ctp ctp_config


# ha_repl
COPY ctp_config /home/ha_repl_01/ctp_config
CMD chown -R ha_repl_01 /home/ha_repl_01/ctp_config
CMD chgrp -R ha_repl_01 /home/ha_repl_01/ctp_config



USER ctp
#RUN cd /home/ctp

RUN git clone https://github.com/CUBRID/cubrid-testtools
RUN git clone https://github.com/CUBRID/cubrid-testcases
RUN cp -rf cubrid-testtools/CTP ./


WORKDIR /home/ctp/ctp_config

# Set the ctp env
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.41.x86_64" >> ${HOME}/.bash_profile
RUN echo "export CTP_HOME=${HOME}/CTP" >> ${HOME}/.bash_profile
RUN sed -i 's@:$HOME/bin@:$HOME/bin:$HOME/CTP/bin:$HOME/CTP/common/script@' ${HOME}/.bash_profile

# copy to ctp config
ADD ctp_config/*.conf /home/ctp/CTP/conf/


USER ha_repl_01

WORKDIR /home/ha_repl_01

RUN git clone https://github.com/CUBRID/cubrid-testtools
RUN cp -rf cubrid-testtools/CTP ./

WORKDIR /home/ha_repl_01/ctp_config

# set the ctp env
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.41.x86_64" >> ${HOME}/.bash_profile
RUN echo "export CTP_HOME=${HOME}/CTP" >> ${HOME}/.bash_profile
RUN echo "export init_path=$HOME/CTP/shell/init_path" >> ${HOME}/.bash_profile
RUN sed -i 's@:$HOME/bin@:$HOME/bin:$HOME/CTP/bin:$HOME/CTP/common/script@' ${HOME}/.bash_profile

 
USER root

