FROM rundeckpro/runner:5.9.0
USER root

#rd-cli
RUN apt update && apt upgrade -y &&\
  apt install curl -y &&\
  curl -s https://packagecloud.io/install/repositories/pagerduty/rundeck/script.deb.sh | os=any dist=any bash &&\
  apt install rundeck-cli -y &&\
  apt install python3 python3-pip -y &&\
      pip install kubernetes &&\
      pip install pywinrm &&\
      pip install pyyaml
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x kubectl && mv kubectl /usr/local/bin/
