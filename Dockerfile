FROM fluent/fluentd:v1.0
MAINTAINER Nicolas Salvo <nicolas.salvo@gmail.com>
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

RUN apk add --update --virtual .build-deps sudo build-base ruby-dev && \
    sudo gem install --no-document fluent-plugin-rewrite-tag-filter && \
    sudo gem install --no-document fluent-plugin-record-reformer && \
    sudo gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 0.25.3 && \
    sudo gem install --no-document fluent-plugin-remote_syslog && \
    sudo gem install --no-document fluent-plugin-loggly && \
    sudo gem sources --clear-all && \
    apk del .build-deps && \
    rm -rf /var/cache/apk/* /home/fluent/.gem/ruby/2.3.0/cache/*.gem

EXPOSE 24284

CMD exec fluentd -c /fluentd/etc/fluent.conf -p /fluentd/plugins $FLUENTD_OPT
