# alpine-base

A Docker image designed for extending from when you need to run [Consul][https://consul.io/] and [Consul Template][https://github.com/hashicorp/consul-template], based on Alpine Linux.

Image size is ~31 MB.

## Features

This image features:

- [Alpine Linux 3.8][https://alpinelinux.org/]
- [s6][http://skarnet.org/software/s6/overview.html] and [s6-overlay][https://github.com/just-containers/s6-overlay]
- [go-dnsmasq][https://github.com/janeczku/go-dnsmasq]
- [Consul][https://www.consul.io/] and [Consul-Template][https://github.com/hashicorp/consul-template]

## Usage

To use this image include `FROM crazyht/alpine-consul-template` at the top of your `Dockerfile`, or simply `docker run --name consul-base crazyht/alpine-consul-template`.

This container has been setup to automatically connect to a Consul cluster, created with a service name of `consul`.

[consul-template][https://github.com/hashicorp/consul-template] is automatically started if templates are available.

## Customisation

To use [consul-template][https://github.com/hashicorp/consul-template]:

1. Add your templates to `/etc/consul-template/templates/my-service/`.
1. Make `consul-template` configuration aware of your templates by adding a configuration file in `/etc/consul-template/conf.d/my-service` (use sub folders to make `VOLUME /etc/consul-template/templates/my-service` possible).
1. In your `Dockerfile` be sure to run `mkfifo /etc/services.d/my-service/supervise/control` and `chmod g+w /etc/services.d/my-service/supervise/control` in order to make it possible for `consul-template` to restart the service if needed.