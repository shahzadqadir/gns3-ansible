FROM ubuntu:22.04

RUN apt update && \
    apt install -y python3-pip && \
    apt install -y vim
RUN apt install -y iputils-ping && \
    apt install -y net-tools && \
    apt install -y openssh-server
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
RUN touch /root/.ssh/config && chmod 600 /root/.ssh/config
RUN pip3 install ansible
RUN pip3 install paramiko
RUN pip3 install requests
RUN ansible-galaxy collection install cisco.ios --force --no-cache
RUN ansible-galaxy collection install cisco.asa --force --no-cache
RUN ansible-galaxy collection install cisco.meraki --force --no-cache
RUN ansible-galaxy collection install juniper.device
RUN ansible-galaxy collection install fortinet.fortios --force --no-cache
