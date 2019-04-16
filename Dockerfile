FROM debian:stretch
MAINTAINER DH

RUN apt-get update && \
    apt-get -y -q install wget gnupg lsb-release && \
    wget http://apt-stable.ntop.org/stretch/all/apt-ntop-stable.deb && \
    dpkg -i apt-ntop-stable.deb && \
    rm -rf apt-ntop-stable.deb && \
    apt-get clean all && \
    apt-get update && \
    apt-get -y -q install pfring nprobe ntopng ntopng-data n2disk cento && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3000

RUN echo '#!/bin/bash\n/etc/init.d/redis-server start\nntopng "$@"' > /tmp/run.sh && \
    chmod +x /tmp/run.sh

ENTRYPOINT ["/tmp/run.sh"]