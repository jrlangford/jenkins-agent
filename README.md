# Jenkins docker agent

This image extends 'jenkinsci/ssh-slave', adding docker and python to it.

The host's docker socket is mounted on the agent's socket location so all dependencies can be deployed to the host as docker images and executed from the agent.

## Usage

**Build the image**
```
docker build -t jrlangford/jenkins-agent .
```

**Run the image**
```
docker run -d \
    -p <host_port>:22 \
    --name jenkins-node \
    -v /var/run/docker.sock:/var/run/docker.sock \
    jrlangford/jenkins-agent "<ssh_key> <user>@<node>"
```
