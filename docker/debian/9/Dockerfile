FROM debian:stretch
ENV container docker

RUN apt-get update -y
RUN apt-get install python3-pip wget unzip gcc python-dev libyaml-dev \
libffi-dev libxml2-dev libxslt-dev puppet git -y


ADD bootstrap/debian/9/hotstrap.sh hotstrap.sh


CMD ["sleep 999999999999"]
ENTRYPOINT ["bash", "-c"]
