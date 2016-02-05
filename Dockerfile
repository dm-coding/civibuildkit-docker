FROM colstrom/fish:ubuntu

MAINTAINER Daniel James <daniel@common.scot>

ENV CIVITYPE drupal-clean
ENV CMS_ROOT /buildkit/build
ENV SITE_NAME "Civi"
ENV SITE_ID "civi"
ENV TMPDIR /buildkit/tmp

RUN apt-get update; apt-get install -y curl links ssmtp
RUN curl -Ls https://civicrm.org/get-buildkit.sh | bash -s -- --full --dir /buildkit

COPY dbconf.sh /buildkit
COPY postinstall.sh /buildkit
COPY mysql.run /etc/service/mysqld/run
COPY apache.run /etc/service/apache2/run
COPY docker-entrypoint.sh /usr/sbin/docker-entrypoint.sh

# Need email? Drop a working ssmtp.conf configuration into the build directory and uncomment the following line:
# COPY ssmtp.conf /etc/ssmtp.conf

# Not allowed? Get an access token from https://github.com/blog/1509-personal-api-tokens
# RUN composer config github-oauth.github.com <token>
# RUN /buildkit/dbconf.sh ; /buildkit/bin/civibuild create civicrm --type drupal-clean --url http://localhost:80 --admin-pass 123
RUN /buildkit/dbconf.sh ; /buildkit/bin/civibuild create civicrm --type $CIVITYPE \
	--url http://${HOST:-localhost}:80 \
	--admin-pass ${ADMINPASS:-s3cr3t}
RUN apt-get install -y runit
RUN /buildkit/postinstall.sh; apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /buildkit/build/civicrm
VOLUME /var/lib/mysql

EXPOSE 80

ENTRYPOINT ["/usr/sbin/docker-entrypoint.sh"]
