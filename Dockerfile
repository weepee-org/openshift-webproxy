FROM gliderlabs/alpine
MAINTAINER Joeri van Dooren <ure@mororless.be>

# https://pkgs.alpinelinux.org/packages?name=php%25&repo=all&arch=x86_64&maintainer=all
RUN apk --update add apache2 apache2-proxy curl && rm -f /var/cache/apk/* && \
mkdir /conf && chown -R apache:apache /conf && \
mkdir /run/apache2/ && \
chmod a+rwx /run/apache2/

# Apache config
ADD httpd.conf /etc/apache2/httpd.conf

# Run scripts
ADD scripts/run.sh /scripts/run.sh
RUN mkdir /scripts/pre-exec.d && \
mkdir /scripts/pre-init.d && \
chmod -R 755 /scripts

# Your proxy conf
ADD conf/proxy.conf /conf/proxy.conf

# Exposed Port
EXPOSE 8080

# VOLUME /conf
WORKDIR /conf

ENTRYPOINT ["/scripts/run.sh"]

# Set labels used in OpenShift to describe the builder images
LABEL io.k8s.description="Alpine linux based Apache PHP Container" \
      io.k8s.display-name="alpine apache php" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,html,apache,php" \
      io.openshift.min-memory="1Gi" \
      io.openshift.min-cpu="1" \
      io.openshift.non-scalable="false"
