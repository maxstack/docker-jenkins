# Jenkins LTS - automated setup

A docker container which automates the setup of Jenkins LTS with a user account and recommended plugins.

## Getting Started

Build your container with the following command
```
docker build -t jenkins:lts-automated
```

Before running your container you will need to provison secrets for the username and password
```
echo "admin" | docker secret create jenkins-user -
echo "your_password" | docker secret create jenkins-pass -
```

Then create a docker volume for the Jenkins application data
```
docker volume create jenkins_home
```

Then run with
```
docker run -d -v jenkins_home:/var/jenkins_home --restart unless-stopped --name jenkins -p 8080:8080 -p 50000:50000 jenkins:lts-automated
```
