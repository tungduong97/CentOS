FROM centos:7

ENV GRIDDB_VERSION=4.3.0
RUN rpm -ivh https://github.com/griddb/griddb_nosql/releases/download/v${GRIDDB_VERSION}/griddb_nosql-${GRIDDB_VERSION}-1.linux.x86_64.rpm

ENV HOME=/var/lib/gridstore
ENV GS_HOME=/var/lib/gridstore
ENV GS_LOG=/var/lib/gridstore/log

WORKDIR $HOME
RUN set -x &&\
su - gsadm -c "gs_passwd admin -p admin"
RUN set -x && \
sed -i -e s/\"clusterName\":\"\"/\"clusterName\":\"dockerGridDB\"/g \
/var/lib/gridstore/conf/gs_cluster.json

WORKDIR /root/
RUN RUN yum install -y wget \
    && yum clean all \
    && wget -q https://github.com/knonomura/griddb-docker/blob/master/griddb-nosql/centos/start-griddb.sh \
    && chmod a+x start-griddb.sh
    && ./start_griddb.sh

WORKDIR $HOME
USER gsadm
