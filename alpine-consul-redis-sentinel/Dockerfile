ARG tag="Dev"

FROM crazyht/alpine-consul-template:$tag

# grab su-exec for easy step-down from root
RUN addgroup -S redis && adduser -S -G redis redis && apk add --no-cache 'su-exec>=0.2'

ENV REDIS_VERSION 4.0.10
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-4.0.10.tar.gz
ENV REDIS_DOWNLOAD_SHA 1db67435a704f8d18aec9b9637b373c34aa233d65b6e174bdac4c1b161f38ca4

# for redis-sentinel see: http://redis.io/topics/sentinel
RUN set -ex; \
	apk add --no-cache --virtual .build-deps \
		coreutils \
		gcc \
		jemalloc-dev \
		linux-headers \
		make \
		musl-dev \
	; \
# Get redis sources
	wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL"; \
	echo "$REDIS_DOWNLOAD_SHA *redis.tar.gz" | sha256sum -c -; \
	mkdir -p /usr/src/redis; \
	tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1; \
	rm redis.tar.gz; \
# disable Redis protected mode [1] as it is unnecessary in context of Docker
# (ports are not automatically exposed when running inside Docker, but rather explicitly by specifying -p / -P)
# [1]: https://github.com/antirez/redis/commit/edd4d555df57dc84265fdfb4ef59a4678832f6da
	grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' /usr/src/redis/src/server.h; \
	sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' /usr/src/redis/src/server.h; \
	grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 0$' /usr/src/redis/src/server.h; \
# for future reference, we modify this directly in the source instead of just supplying a default configuration flag because apparently "if you specify any argument to redis-server, [it assumes] you are going to specify everything"
# see also https://github.com/docker-library/redis/issues/4#issuecomment-50780840
# (more exactly, this makes sure the default behavior of "save on SIGTERM" stays functional by default)
	make -C /usr/src/redis -j "$(nproc)"; \
	make -C /usr/src/redis install; \
# remove redis sources
	rm -r /usr/src/redis; \
	\
	runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"; \
	apk add --virtual .redis-rundeps $runDeps; \
	apk del .build-deps; \
	redis-server --version && \
    apk add --update --no-cache gawk

# Add the files.
ADD root /

RUN chown redis:redis /etc/sentinel.conf && chmod 666 /etc/sentinel.conf

ENV REDIS_PORT 6379
ENV SENTINEL_PORT 26379
ENV CONSUL_REDIS_SVCNAME Redis
ENV CONSUL_SENTINEL_SVCNAME Redis-Sentinel
ENV SENTINEL_FAILOVER_TIMEOUT 180000
ENV SENTINEL_DOWN_AFTER 30000
ENV SENTINEL_QUORUM 2
ENV SENTINEL_PARALLEL_SYNC 1
# Expose the ports for redis.
EXPOSE 26379