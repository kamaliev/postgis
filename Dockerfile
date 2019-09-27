FROM postgres:10

RUN bash -c 'echo "deb http://apt.postgresql.org/pub/repos/apt xenial-pgdg main" >> /etc/apt/sources.list' \	
	&& apt-get update && apt-get install -y --no-install-recommends ca-certificates wget \
	&& wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add - \
	&& apt-get update && apt-get install -y --no-install-recommends \
		postgresql-10-postgis-2.4 \
		postgresql-10-postgis-scripts \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get purge -y --auto-remove ca-certificates wget \
	&& rm -rf /var/lib/apt/lists/* \
	&& tempDir="$(mktemp -d)" \
	&& rm -rf "$tempDir" /etc/apt/sources.list.d/temp.list

CMD ["postgres"]

EXPOSE 5432