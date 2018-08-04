{
    "service": {
        "name": "{{.Env.CONSUL_SENTINEL_SVCNAME}}",
        "port": {{.Env.SENTINEL_PORT}},
        "checks": [
          {
            "args": ["sentinel-check"],
            "id": "redis-sentinel",
            "name": "redis-sentinel",
            "interval": "2s",
            "timeout": "1s"
          }
        ]
    }
}