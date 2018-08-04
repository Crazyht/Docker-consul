{
  "name": "{{.Env.CONSUL_REDIS_SVCNAME}}",
  "tags": [
    "slave"
  ],
  "enable_tag_override": true,
  "port": {{.Env.REDIS_PORT}}
}