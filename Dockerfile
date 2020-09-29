FROM centos:7

#Install Development Tools
RUN set -eux \
    && yum install -y java-1.8.0-openjdk-devel ant python3 zlib-devel \
    && yum groupinstall -y "Development Tools"  \
    && yum clean all

#RUN ln -sf /usr/bin/python3 /usr/bin/python
COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh

#Add user
RUN groupadd -r griddb && useradd -r -g griddb griddb
#RUN adduser -r -u 1001 centos
#RUN useradd -r -u 1001 -g centos
RUN usermod -aG wheel griddb
USER griddb
WORKDIR /home/griddb
RUN chmod -R 777 /home/griddb
#USER 1001:1001
CMD ["/bin/bash", "/docker-entrypoint.sh"]
