# docker build -t mkttf .
# docker run -v "$PWD:/mkttf" --env TERMINUS_VERSION=4.47 mkttf
FROM ubuntu:18.04
MAINTAINER Stanislaw Pusep <stas@sysd.org>
ENV TERMINUS_VERSION=4.47

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    bsdtar \
    build-essential \
    fontforge \
    potrace \
    python-fontforge \
    python-pip \
    rename \
    wget

RUN pip install bdflib
RUN wget --no-verbose \
        http://hp.vector.co.jp/authors/VA013651/lib/mkbold-mkitalic-0.11.tar.bz2 \
        https://raw.githubusercontent.com/Lokaltog/vim-powerline/develop/fontpatcher/fontpatcher \
        https://raw.githubusercontent.com/Lokaltog/vim-powerline/develop/fontpatcher/PowerlineSymbols.sfd \
    && tar xjf mkbold-mkitalic-0.11.tar.bz2 \
    && cd mkbold-mkitalic-0.11/ \
    && make install \
    && rm -rf /mkbold-mkitalic* \
    && mkdir /mkttf

RUN DEBIAN_FRONTEND=noninteractive apt-get purge -y \
    build-essential \
    python-pip
RUN DEBIAN_FRONTEND=noninteractive apt-get autoremove -y --purge
RUN DEBIAN_FRONTEND=noninteractive apt-get clean

WORKDIR /mkttf

CMD ["./terminus_powerline.sh"]
