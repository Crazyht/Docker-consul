{
  "service": {
    "name": "{{.Env.CONSUL_SVCNAME}}",
    "tags": [
      "starting"
    ],
    "enable_tag_override": true,
    "port": {{.Env.SERVICE_PORT}},
    "checks": [
      {
        "args": ["rabbitmqctl node_health_check -t 5 -q || exit 2"],
        "id": "rabbit",
        "name": "rabbit",
        "interval": "10s",
        "timeout": "6s"
      }
    ]
  }
}
