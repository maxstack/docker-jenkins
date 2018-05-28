FROM jenkins/jenkins:lts-alpine

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
 
COPY security.groovy /var/jenkins_home/init.groovy.d/
 
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root

RUN apk add --no-cache docker openrc shadow sudo \
 && rc-update add docker boot

RUN gpasswd -a jenkins docker
RUN echo "jenkins ALL=(ALL) NOPASSWD: /usr/bin/docker" >> /etc/sudoers
RUN echo "alias docker='sudo docker '" >> /etc/profile

user jenkins
