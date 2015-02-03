# Jackal Webhook

Pipeline entry point via HTTP end point. Accepts `POST` payloads which are
automatically packaged into expected payload format and injected into the
pipeline.


## Configuration

### Webhook configuration

This webhook service is built using the Jackal `HttpApi` utility. It can provide
multiple end points and configuration is isolated to a single entry:

```json
{
  "jackal": {
    "http_hook": {
      "bind": "0.0.0.0",
      "port": 9090,
      "ssl": {
        "cert": "/path/to/cert",
        "key": "/path/to/key"
      },
      "authorization": {
        "allowed_origins": [],
        "htpasswd": "/path/to/file",
        "credentials": {
          USER: PASS
        },
        "valid_on": "any" / "all"
      }
    }
  }
}
```

### Payload configuration

The newly created payload can have its name set via configuration:

```json
{
  "jackal": {
    "webhook": {
      "job_name": JOB_NAME
    }
  }
}
```

## Usage

The web hook will accept POST requests to the given path:

```
/VERSION/ACTION[/EXTRA]
```

* `VERSION` regex format: `v[\d]+`
* `ACTION` regex format: `[A-Za-z0-9-_]+`
* `EXTRA` remaining string

This will result in a new payload injected into the pipeline and
sent to the configured `output` source. The structure of the payload:

```json
{
  "name": JOB_NAME_OR_NAMESPACE,
  "data": {
    ACTION: REQUEST_BODY,
    "webhook": {
      "version": VERSION,
      "action": ACTION,
      "path_extra": EXTRA,
      "headers": HTTP_HEADERS,
      "query": QUERY_PARAMETERS
    }
  }
}
```

# Info

* Repository: https://github.com/carnviore-rb/jackal-webhook
* IRC: Freenode @ #carnivore
