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

# Supported tags and respective `Dockerfile` links

- [`latest`](https://github.com/pagerduty-cse/pd-enterprise-runner/blob/main/Dockerfile)

# What's included

- Java 11
- Rundeck Enterprise Runner
- RD-CLI

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
-e RUNNER_RUNDECK_SERVER_TOKEN=YOUR_RUNNER_SERVER_TOKEN \
-e RUNNER_RUNDECK_CLIENT_ID=YOUR_RUNNER_ID \
-e RUNNER_RUNDECK_SERVER_URL=YOUR_RUNDECK_SERVER_URL \
-e RD_URL=YOUR_RUNDECK_SERVER_URL \
-e RD_TOKEN=YOUR_RUNDECK_TOKEN pagerdutycs/pd-enterprise-runner:latest
```

### Docker-compose

```yaml
version: "3"
services:
  enterprise-runner:
    image: pagerdutycs/pd-enterprise-runner:latest
    container_name: enterprise-runner
    hostname: enterprise-runner
    environment:
      RUNNER_RUNDECK_SERVER_TOKEN: ${RUNNER_RUNDECK_SERVER_TOKEN}
      RUNNER_RUNDECK_SERVER_URL: ${RUNNER_RUNDECK_SERVER_URL}
      RUNNER_RUNDECK_CLIENT_ID: ${RUNNER_RUNDECK_CLIENT_ID}
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
