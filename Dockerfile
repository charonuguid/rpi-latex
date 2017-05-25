FROM resin/rpi-raspbian:latest
MAINTAINER Charo Nuguid <me@thegeekettespeaketh.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y \
        perl-tk \
        wget \
        python \
    && apt-get clean

RUN wget http://mirror.pregi.net/tex-archive/systems/texlive/tlnet/install-tl-unx.tar.gz \
	&& tar -zxf install-tl-unx.tar.gz \
    && mkdir -p /profiles/ \
    && mkdir -p /source

ENV PATH /usr/local/texlive/2016/bin/armhf-linux:$PATH
ENV INFOPATH /usr/local/texlive/2016/texmf-dist/doc/info
ENV MANPATH /usr/local/texlive/2016/texmf-dist/doc/man

COPY texlive.profile /profiles/

RUN cd install-tl-*/ \
	&& ./install-tl --profile=/profiles/texlive.profile
RUN tlmgr install texliveonfly

WORKDIR /source

ENTRYPOINT ["texliveonfly"]
