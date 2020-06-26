FROM ubuntu:20.04

ENV TAPYRUS_VERSION='v0.4.0'

RUN apt-get update && \
    apt-get install -y wget && \
    wget https://github.com/chaintope/tapyrus-core/releases/download/${TAPYRUS_VERSION}/tapyrus-core-${TAPYRUS_VERSION}-x86_64-pc-linux-gnu.tar.gz && \
    tar -xzvf tapyrus-core-${TAPYRUS_VERSION}-x86_64-pc-linux-gnu.tar.gz tapyrus-x86_64-pc-linux-gnu/bin/ && \
    mv tapyrus-x86_64-pc-linux-gnu/bin/* /usr/local/bin/ && \
    rm -rf tapyrus-core-${TAPYRUS_VERSION}-x86_64-pc-linux-gnu.tar.gz tapyrus-x86_64-pc-linux-gnu/

ENV DATA_DIR='/var/lib/tapyrus' \
    CONF_DIR='/etc/tapyrus'
RUN mkdir ${DATA_DIR} && mkdir ${CONF_DIR}

# p2p port (Production/Development) rpc port (Production/Development)
EXPOSE 2357 12383 2377 12381

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
CMD ["tapyrusd -datadir=${DATA_DIR} -conf=${CONF_DIR}/tapyrus.conf"]
