FROM ubuntu:22.04

RUN apt update && apt install -y python3-pip && \
    apt install -y vim

# Install Ansible and related software

RUN pip3 install ansible
RUN pip3 install paramiko
RUN pip3 install requests
RUN ansible-galaxy collection install cisco.ios --force --no-cache
RUN ansible-galaxy collection install cisco.asa --force --no-cache
RUN ansible-galaxy collection install cisco.meraki --force --no-cache
RUN ansible-galaxy collection install juniper.device
RUN ansible-galaxy collection install fortinet.fortios --force --no-cache

# Add a user & setup shell
RUN useradd -ms /bin/bash script  
RUN echo 'script:cisco123' | chpasswd


RUN apt install -y iputils-ping && \
    apt install -y net-tools && \
    apt install -y openssh-server

RUN mkdir /var/run/sshd

USER script

RUN mkdir -p /home/script/.ssh && \
    chmod 700 /home/script/.ssh

RUN touch /home/script/.ssh/config && \
chmod 600 /home/script/.ssh/config

VOLUME ["/home/script/ansible", "/home/script/playbooks"]

USER root
EXPOSE 22

RUN mkdir -p /home/script/ansible && \
    mkdir -p /home/script/playbooks

# to ssh using VSCode make sure you have ~/.ssh/config has following
# manullay start ssh service in docker as can't be baked in image.
# Host 10.10.100.100
#     User script
#     IdentityFile ~/.ssh/id_rsa
# you will need to copy ~/.ssh/id_rsa.pub to docker container ~/.ssh/authorized_keys
