{
  "service": {
    "name": "{{.Env.CONSUL_REDIS_SVCNAME}}",
    "tags": [
      "starting"
    ],
    "enable_tag_override": true,
    "port": {{.Env.REDIS_PORT}},
    "checks": [
      {
        "args": ["redis-check"],
        "id": "redis",
        "name": "redis",
        "interval": "2s",
        "timeout": "1s"
      }
    ]
  }
}