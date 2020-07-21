FROM debian:buster
ENV container docker

RUN apt-get update -y
RUN apt-get install apt-utils python3-pip python3-venv wget unzip gcc python-dev libyaml-dev \
libffi-dev libxml2-dev libxslt-dev puppet git -y

ADD bootstrap/debian/10/hotstrap.sh hotstrap.sh


CMD ["sleep 999999999999"]
ENTRYPOINT ["bash", "-c"]
