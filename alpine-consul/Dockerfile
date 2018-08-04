FROM crazyht/alpine-s6:latest

ENV CONSUL_VERSION=1.2.1 \
    CONSUL_DOMAIN=consul \
    CONSUL_DATA_DIR=/data/consul \
    CONSUL_CONFIG_DIR=/etc/consul/conf.d/bootstrap \
    CONSUL_SERVER_NAME=consul \
    CONSUL_DC=dc1 \
    CONSUL_CLIENT=0.0.0.0 \
    CONSUL_RETRY_INTERVAL=5s

# Download and install Consul
RUN apk upgrade --update --no-cache && \
    apk add --update --no-cache util-linux && \
    curl -sSLo /tmp/consul.zip https://releases.hashicorp.com/consul/{$CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip && \
    unzip -d /bin /tmp/consul.zip && \
    rm /tmp/consul.zip && \
    # create user and give binary permissions to bind to lower port
    addgroup consul && \
    adduser -D -g "" -s /bin/sh -G consul consul && \
    mkdir -p /data/consul && \
    chown -R consul:consul /data/consul

# Add the files
COPY root /

VOLUME ["/data/consul"]

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8500 8600 8600/udp 53 53/udp
# Server RPC (Default 8300). This is used by servers to handle incoming requests from other agents. TCP only.
# Serf LAN (Default 8301). This is used to handle gossip in the LAN. Required by all agents. TCP and UDP.
# Serf WAN (Default 8302). This is used by servers to gossip over the WAN to other servers. TCP and UDP.
# HTTP API (Default 8500). This is used by clients to talk to the HTTP API. TCP only.
# DNS Interface (Default 8600). Used to resolve DNS queries. TCP and UDP.