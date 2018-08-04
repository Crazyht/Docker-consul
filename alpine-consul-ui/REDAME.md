# alpine-consul-ui

A Docker image for running [Consul with UI][https://www.consul.io/], based on Alpine Linux.

Image size is ~38 MB.

## Features

This image features:

- [Alpine Linux 3.8][https://alpinelinux.org/]
- [s6][http://skarnet.org/software/s6/overview.html] and [s6-overlay][https://github.com/just-containers/s6-overlay]
- [go-dnsmasq][https://github.com/janeczku/go-dnsmasq]
- [Consul][https://www.consul.io/]

## Usage

To use this image include `FROM crazyht/alpine-consul-ui` at the top of your `Dockerfile`, or simply `docker run --name consul-ui crazyht/alpine-consul-ui`.

This container has been setup to automatically connect to a Consul cluster, created with a service name of `consul`. 