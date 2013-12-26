FROM ubuntu
MAINTAINER Cameron Boehmer <cameron.boehmer@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get -y install git
RUN apt-get -y install npm
RUN apt-get -y install nodejs

RUN git clone https://github.com/cameronboehmer/brackets.git

WORKDIR brackets
RUN git checkout in-browser
RUN git submodule update --init

WORKDIR brackets/src
RUN npm install
RUN cd nativeServer; npm install

WORKDIR brackets
CMD ["tools/run_in_docker.sh"]

EXPOSE 9000
EXPOSE 80