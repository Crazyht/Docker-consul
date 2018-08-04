# alpine-base

A Docker image for running just about anything within a container, based on Alpine Linux.

Image size is ~13.8 MB.

## Features

This image features:

- [Alpine Linux 3.8][https://alpinelinux.org/]
- [s6][http://skarnet.org/software/s6/overview.html] and [s6-overlay][https://github.com/just-containers/s6-overlay]
- [go-dnsmasq][https://github.com/janeczku/go-dnsmasq]

### DNS

Prior to v4.4, Alpine Linux did not support the `search` keyword in `resolv.conf`. This breaks many tools that rely on DNS service discovery, in particular, Kubernetes, Docker Cloud, Consul, Rancher.

To overcome these issues, `alpine-base` includes the lightweight container-only DNS server [go-dnsmasq][godnsmasq] to resolve these issues.

That means that any image extending this image will now work with [Docker Cloud service discovery and links](https://docs.docker.com/docker-cloud/apps/service-links/) and [Kubernetes service discovery](https://github.com/kubernetes/kubernetes/blob/master/docs/user-guide/services.md#dns).

In some environments, `go-dnsmasq` won't be allowed to bind to port `53`. In this instance, you can set the ENV variable `GO_DNSMASQ_RUNAS` to `root`. While not ideal, that should resolve the issue.

**Note**: despite Alpine Linux v4.4 adding support for the `search` keyword, `go-dnsmasq` has been retained for compatibility. It may or may not be included in future versions.

