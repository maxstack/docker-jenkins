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

To pass through your AWS credentials expor the following two vars on the host machine
```
AWS_ACCESS_KEY_ID=$(aws --profile default configure get aws_access_key_id)
AWS_SECRET_ACCESS_KEY=$(aws --profile default configure get aws_secret_access_key)
```

Then run the container with
```
docker run -d -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --restart unless-stopped --name jenkins -p 8080:8080 -p 50000:50000 jenkins:lts-automated
```


## Adding plugins to the build

If you would like to add new plugins to the image, run this container and install the desired plugins, then generate a new list using the following command:
```
curl -s -k "http://_USERNAME_:_PASSWORD_@localhost:8080/pluginManager/api/json?depth=1" | jq -r '.plugins[].shortName' | tee plugins.txt
```

Then update the plugins.txt inside this repo and rebuild.
