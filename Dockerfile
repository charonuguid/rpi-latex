FROM resin/rpi-raspbian:latest
MAINTAINER Charo Nuguid <me@thegeekettespeaketh.com>

RUN apt-get update && apt-get install -y \
wget \
python \
perl \
&& apt-get clean

RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
&& tar -xzf install-tl-unx.tar.gz \
&& mkdir -p /profiles/ \
&& mkdir -p /source

ENV PATH /usr/local/texlive/2015/bin/armhf-linux:$PATH
ENV INFOPATH /usr/local/texlive/2015/texmf-dist/doc/info
ENV MANPATH /usr/local/texlive/2015/texmf-dist/doc/man

COPY texlive.profile /profiles/

RUN cd install-tl-*/ && \
    ./install-tl --profile=/profiles/texlive.profile && \
    tlmgr install texliveonfly

WORKDIR /source

ENTRYPOINT ["texliveonfly"]

