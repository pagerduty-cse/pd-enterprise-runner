FROM rundeckpro/runner

USER root

#rd-cli
RUN apt update && apt upgrade -y &&\
  apt install curl -y &&\
  curl -s https://packagecloud.io/install/repositories/pagerduty/rundeck/script.deb.sh | os=any dist=any bash &&\
  apt install rundeck-cli -y

USER runner
