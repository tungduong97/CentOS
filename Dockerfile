FROM centos:7

ENV GRIDDB_VERSION=4.3.0
RUN rpm -ivh https://github.com/griddb/griddb_nosql/releases/download/v${GRIDDB_VERSION}/griddb_nosql-${GRIDDB_VERSION}-1.linux.x86_64.rpm

ENV GS_HOME=/var/lib/gridstore
ENV GS_LOG=/var/lib/gridstore/log

WORKDIR /root/
RUN set -x &&\
su - gsadm -c "gs_passwd admin -p admin"
RUN set -x && \
sed -i -e s/\"clusterName\":\"\"/\"clusterName\":\"dockerGridDB\"/g \
/var/lib/gridstore/conf/gs_cluster.json

COPY start-griddb.sh /usr/local/bin/
RUN ln -s /usr/local/bin/start-griddb.sh entrypoint.sh
RUN chmod a+x entrypoint.sh
CMD ["/bin/bash", "./entrypoint.sh"]
