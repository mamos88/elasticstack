FROM docker.elastic.co/logstash/logstash:8.10.0
RUN rm -f /usr/share/logstash/pipeline/logstash.conf
COPY --chown=logstash:root logstash.yml /usr/share/logstash/config/logstash.yml
COPY --chown=logstash:root logstash.conf /usr/share/logstash/pipeline/logstash.conf
COPY --chown=logstash:root elastic-certificates.p12 /usr/share/logstash/config/elastic-certificates.p12
