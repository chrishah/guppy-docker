FROM ubuntu:20.04

MAINTAINER <christoph.hahn@uni-graz.at>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
## preesed tzdata, update package index, upgrade packages and install needed software
RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
	echo "tzdata tzdata/Zones/Europe select Vienna" >> /tmp/preseed.txt; \
	debconf-set-selections /tmp/preseed.txt && \
	apt-get update && \
	apt-get install -y tzdata wget build-essential python3 python3-pip

#WORKDIR /usr/src
#RUN wget https://mirror.oxfordnanoportal.com/software/analysis/ont_guppy_cpu_4.5.4-1~focal_amd64.deb
#RUN dpkg -i ont_guppy_cpu_4.5.4-1~focal_amd64.deb

#lsb-release

#ENV PLATFORM="$(lsb_release -cs)"
RUN wget -qO - https://mirror.oxfordnanoportal.com/apt/ont-repo.pub | apt-key add - && \
	echo "deb http://mirror.oxfordnanoportal.com/apt focal-stable non-free" | tee /etc/apt/sources.list.d/nanoporetech.sources.list && \
	apt-get update

RUN apt install -y ont-guppy-cpu=4.5.4-1~focal
