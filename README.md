# Jenkins LTS - automated setup

A docker container which automates the setup of Jenkins LTS with a user account and recommended plugins.

## Getting Started

Set the default username and password via the following commands
```
sed -i -e 's/_USERNAME_/admin/g' security.groovy
sed -i -e 's/_PASSWORD_/somecomplexpassword/g' security.groovy
```

Build your container with the following command
```
docker build -t jenkins:lts-automated .
```

Then run with
```
docker run -d -v jenkins_home:/var/jenkins_home --restart unless-stopped --name jenkins -p 8080:8080 -p 50000:50000 jenkins:lts-automated
```
