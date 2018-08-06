ARG tag="dev"

FROM crazyht/alpine-consul:$tag

ENV CONSUL_DATA_DIR=/data/consul \
    CONSUL_CONFIG_DIR=/etc/consul.d

# Add the files
ADD root /