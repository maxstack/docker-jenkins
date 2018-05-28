# Jenkins LTS - automated setup with Docker inside Docker

A docker container which automates the setup of Jenkins LTS with a user account and recommended plugins, and access to the host's docker engine.

## Getting Started

Set the default username and password via the following commands
```
sed -i -e 's/_USERNAME_/admin/g' security.groovy
sed -i -e 's/_PASSWORD_/somecomplexpassword/g' security.groovy
```

Build your container with the following command
```
docker build --build-arg GID=$(grep docker /etc/group | cut -d: -f3) -t jenkins:lts-automated .
```

Then run with
```
docker run -d -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --build-arg --restart unless-stopped --name jenkins -p 8080:8080 -p 50000:50000 jenkins:lts-automated
```


## Adding plugins to the build

If you would like to add new plugins to the image, run this container and install the desired plugins, then generate a new list using the following command:
```
curl -s -k "http://_USERNAME_:_PASSWORD_@localhost:8080/pluginManager/api/json?depth=1" | jq -r '.plugins[].shortName' | tee plugins.txt
```

Then update the plugins.txt inside this repo and rebuild.
