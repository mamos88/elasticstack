FROM docker.elastic.co/kibana/kibana:8.9.0
COPY --chown=kibana:root kibana.yml /usr/share/kibana/config/kibana.yml
COPY --chown=kibana:root elastic-certificates.p12 /usr/share/kibana/config/elastic-certificates.p12
