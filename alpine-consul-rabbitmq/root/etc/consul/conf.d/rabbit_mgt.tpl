{
  "service": {
    "name": "{{.Env.CONSUL_SVCNAME}}-Management",
    "tags": [
      "starting"
    ],
    "enable_tag_override": true,
    "port": {{.Env.MANAGEMENT_PORT}},
    "checks": [
      {
        "id": "mgt",
        "name": "Web Management",
        "http": "http://localhost:{{.Env.MANAGEMENT_PORT}}/",
        "method": "GET",
        "interval": "10s",
        "timeout": "2s"
      }
    ]
  }
}
