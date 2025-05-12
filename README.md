# Quick reference

-	**Maintained by**:  
	Customer Success Engineering @ [PagerDuty](https://www.pagerduty.com/)

-	**Where to get help**:  
	- For help with the Docker images please contact the Customer Success Engineering team at <cse@pagerduty.com>.
	- For help with Enterprise Runner visit the [Rundeck documentation](https://docs.rundeck.com/docs/administration/runner/#runner).
	- Rundeck CLI please check out the [Rundeck RD-CLI User Guide](https://docs.rundeck.com/docs/rd-cli/).

-	**Where to file issues**:  
	Issues can be filed on [GitHub](https://github.com/pagerduty-cse/pd-enterprise-runner/issues)

-	**Source of this description**:  
	[GitHub repo's README](https://github.com/pagerduty-cse/pd-enterprise-runner/blob/main/README.md)

# Supported tags

- `5.12.0`
- `5.11.1`
- `5.11.0`
- `5.9.0`
- `5.7.0`
- `5.5.0`
- `5.2.0`
- `5.0.1`
- `5.0.0`
- `0.1.53`

# What's included

- Java 11
- Rundeck Enterprise Runner
- RD-CLI
- Python3 (kubernetes and winrm modules)
- kubectl

# How to use this image

This image is based on the [official Rundeck image](https://hub.docker.com/r/rundeckpro/runner), it is expecting below [environment variables](https://docs.rundeck.com/docs/administration/runner/#docker-environment-variables):
- RUNNER_RUNDECK_SERVER_URL: url for your Rundeck service.
- RUNNER_RUNDECK_SERVER_TOKEN and RUNNER_RUNDECK_CLIENT_ID: these 2 should be obtained using the API to [create a runner](https://docs.rundeck.com/docs/api/rundeck-api.html#create-a-new-runner) or [regenerete a runner's credentials](https://docs.rundeck.com/docs/api/rundeck-api.html#regenerate-credentials-for-the-runner).

Environment variables for RD-CLI:
- As in the [documentation](https://docs.rundeck.com/docs/learning/howto/learn-rd-cli.html#configuration).

## Usage

### Command line

Starting a PagerDuty Enterprise Runner container is simple:
```
$ docker run -dit --name enterprise-runner \
-e RUNNER_RUNDECK_CLIENT_ID=$RUNNER_RUNDECK_CLIENT_ID \
-e RUNNER_RUNDECK_SERVER_TOKEN=$RUNNER_RUNDECK_SERVER_TOKEN \
-e RUNNER_RUNDECK_SERVER_URL=$RUNNER_RUNDECK_SERVER_URL \
-e RD_URL=$RD_URL \
-e RD_TOKEN=$RD_TOKEN pagerdutycs/pd-enterprise-runner:5.7.0
```

### Docker-compose

```yaml
version: "3"
services:
  enterprise-runner:
    image: pagerdutycs/pd-enterprise-runner:5.12.0
    container_name: enterprise-runner
    hostname: enterprise-runner
    environment:
      RUNNER_RUNDECK_CLIENT_ID: ${RUNNER_RUNDECK_CLIENT_ID}
      RUNNER_RUNDECK_SERVER_TOKEN: ${RUNNER_RUNDECK_SERVER_TOKEN}
      RUNNER_RUNDECK_SERVER_URL: ${RUNNER_RUNDECK_SERVER_URL}
      RD_URL: ${RD_URL}
      RD_TOKEN: ${RD_TOKEN}
  ```

To log into a bash shell of your container:
```
$ docker exec -it enterprise-runner bash
```

To run RD-CLI commands from the host (this example shows the system information):
```
$ docker exec -it enterprise-runner rd system info
```

### Kubernetes deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: enterprise-runner
  labels:
    app: enterprise-runner
spec:
  replicas: 1
  selector:
    matchLabels:
      app: enterprise-runner
  template:
    metadata:
      labels:
        app: enterprise-runner
    spec:
      containers:
      - image: pagerdutycs/pd-enterprise-runner:5.12.0
        imagePullPolicy: Always
        name: enterprise-runner
        env:
        - name: RUNNER_RUNDECK_CLIENT_ID
          value: ${RUNNER_RUNDECK_CLIENT_ID}
        - name: RUNNER_RUNDECK_SERVER_TOKEN
          value: ${RUNNER_RUNDECK_SERVER_TOKEN}
        - name: RUNNER_RUNDECK_SERVER_URL
          value: ${RUNNER_RUNDECK_SERVER_URL}
        - name: RD_URL
          value: ${RD_URL}
        - name: RD_TOKEN
          value: ${RD_TOKEN}
```
