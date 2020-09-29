FROM centos:7

#Install Development Tools
RUN set -eux \
    && yum install -y java-1.8.0-openjdk-devel ant python3 zlib-devel \
    && yum groupinstall -y "Development Tools"  \
    && yum clean all
#Add user
#RUN groupadd -r griddb && useradd -r -g griddb gsadm
RUN adduser -S -D -u 1001 -s /sbin/nologin -g "API Simulator User" -G centos centos \
    && chown -R centos:root /griddb_nosql \
    && chmod -R 0775 /griddb_nosql
#RUN useradd -r -u 1001 -g centos
#RUN usermod -aG wheel centos
#RUN ln -sf /usr/bin/python3 /usr/bin/python
COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh
USER 1001
#USER 1001:1001
WORKDIR /griddb_nosql
CMD ["/bin/bash", "/docker-entrypoint.sh"]
