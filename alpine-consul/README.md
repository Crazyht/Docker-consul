# alpine-base

A Docker image designed for extending from when you need to run [Consul][https://consul.io/], based on Alpine Linux.

Image size is ~28 MB.

## Features

This image features:

- [Alpine Linux 3.8][https://alpinelinux.org/]
- [s6][http://skarnet.org/software/s6/overview.html] and [s6-overlay][https://github.com/just-containers/s6-overlay]
- [go-dnsmasq][https://github.com/janeczku/go-dnsmasq]
- [Consul][https://www.consul.io/]

## Usage

To use this image include `FROM crazyht/alpine-consul` at the top of your `Dockerfile`, or simply `docker run --name consul crazyht/alpine-consul`.

By default, Consul has been configured with zero-conf Consul bootstrapping (to take advantage of zero-conf Consul bootstrapping, Docker 1.10+ is required).

To use this image to setup a Consul cluster with 3 nodes via Docker Compose, add the following to your `docker-compose.yml` file:

```
version: '2'

services:
    consul:
        image: smebberson/alpine-consul:latest
```

Then start with `docker-compose up -d && docker-compose scale consul=3`. You don't need to worry about bootstrapping the Consul cluster, everything just works.

## Customisation

This container comes setup as follows:

- Consul will automatically start.
- If Consul dies, it will automatically be restarted (the container will remain running).

All configuration has been defined in the `/etc/consul/conf.d/bootstrap/config.json` file.

To customise configuration for `consul`, replace the file at `/etc/consul/conf.d/bootstrap/config.json` with your own configuration.

To customise the start script for `consul`, replace the file at `/etc/services.d/consul/run` with your own start script.

### Consul DNS domain

By default, Consul's DNS domain is `consul.`. This allows you to make DNS queries such as `nginx.service.consul` to find all IPs relating to the `nginx` service (for example). Through customizing the environment variable `CONSUL_DOMAIN` you can alter Consul's DNS domain.

For example, add `ENV CONSUL_DOMAIN=dockeralpine` to your `Dockerfile` and you'll be able to make a DNS query for `nginx.service.dockeralpine` rather than the default.

You can read more about [Consul's DNS interface here][https://www.consul.io/docs/agent/dns.html].

### Consul DC

By default, Consul runs itself in data center `dc1`. Through customizing the environment variable `CONSUL_DC` you can alter Consul's data center configuration.

For example, ADD `ENV CONSUL_DC=dc2` to your `Dockerfile` and you'll be able to make a DNS query for `nginx.service.dc2.dockeralpine` rather than the default.

### Consul Advertise WAN

By default, Consul advertises itself with the address that it binds to. Within a container the bind address is Dockers private IP and in a multi data center setup that IP would not be reachable. Through customizing the environment variable `CONSUL_ADVERTISE_WAN` you can alter the IP Consul reports to WAN.

For example, `docker run -e "CONSUL_ADVERTISE_WAN=`ifconfig | grep -A 1 'ens4' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1`"` where ens4 is the interface with a reachable IP.

### Consul join WAN

To join Consul server to through WAN to another Consul use environmental variable `CONSUL_JOIN_WAN`. Through customizing this environmental variable you can make Consul communicate across WAN.

For example, `docker run -e "CONSUL_JOIN_WAN=10.128.0.2"` would make Consul reach out to and register itself with `10.128.0.2`.

### Consul translate WAN

By default, Consul does not translate IPs when in WAN. Service discovery from dc1 will return private IPs of dc2. Through customizing the environment variable `CONSUL_TRANSLATE_WAN` you can make Consul to resolve to IP specified with `CONSUL_ADVERTISE_WAN`.

For example, `docker run -e "CONSUL_TRANSLATE_WAN=true"` Consul will resolve to IP defined with `CONSUL_ADVERTISE_WAN`.

## Debugging

The scripts involved in bootstrapping Consul can output debug information if required. To enable set `CONSUL_BOOTSTRAP_DEBUG` to `true`. You can customise the log file location from the default of `/var/log/consul-bootstrap/consul-bootstrap.log` by setting `CONSUL_BOOTSTRAP_LOG_FILE`.