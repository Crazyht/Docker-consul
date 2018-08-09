{
  "service": {
    "name": "{{.Env.CONSUL_SVCNAME}}",
    "tags": [
      "starting"
    ],
    "enable_tag_override": true,
    "port": {{.Env.SERVICE_PORT}}
  }
}
