FROM jenkins/jenkins:lts-alpine
 
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
 
COPY security.groovy /var/jenkins_home/init.groovy.d/
 
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root

RUN apk add --no-cache docker openrc shadow \
 && rc-update add docker boot \
 && usermod -aG docker jenkins \
 && touch /var/run/docker.sock \
 && chmod 777 /var/run/docker.sock

user jenkins
