FROM centos:7

#Install Development Tools
RUN set -eux \
    && yum install -y java-1.8.0-openjdk-devel ant python3 zlib-devel \
    && yum groupinstall -y "Development Tools"  \
    && yum clean all
#Add user
#RUN groupadd -r griddb && useradd -r -g griddb gsadm
RUN useradd -r -u 1001 -g appuser appuser
#RUN useradd -r -u 1001 -g centos
#RUN usermod -aG wheel centos
#RUN ln -sf /usr/bin/python3 /usr/bin/python
COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh
USER appuser
#USER 1001:1001
WORKDIR /home/appuser
CMD ["/bin/bash", "/docker-entrypoint.sh"]
