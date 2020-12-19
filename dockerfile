FROM php:7.4-apache

RUN apt-get update \	
	&& apt-get install -qqy unzip libaio1 libapache2-mod-shib2 ssl-cert --no-install-recommends \
	&& apt-get clean autoclean && apt-get autoremove --yes # && rm -rf /var/lib/apt/lists/*

COPY lib/start.sh /usr/local/bin
RUN chmod a+x /usr/local/bin/start.sh

#------------ Shibboleth
COPY lib/shibboleth2.xml /etc/shibboleth/
	
#------------ configura apache
COPY lib/default.conf /etc/apache2/sites-available/

#------------ the end
EXPOSE 80
ENTRYPOINT ["start.sh"]