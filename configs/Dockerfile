FROM docker.elastic.co/elasticsearch/elasticsearch:8.9.0
COPY --chown=elasticsearch:root elasticsearch-node1.yml /usr/share/elasticsearch/config/elasticsearch.yml
COPY --chown=elasticsearch:root elastic-certificates.p12 /usr/share/elasticsearch/config/elastic-certificates.p12
