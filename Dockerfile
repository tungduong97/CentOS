FROM centos:7

#Install Development Tools
#RUN set -eux \
#    && yum groupinstall -y "Development Tools" \
#    && yum clean all
#Add user
#RUN groupadd -r griddb && useradd -r -g griddb gsadm
RUN useradd centos
RUN usermod -aG admin centos

COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh
CMD ["/bin/bash", "/docker-entrypoint.sh"]
