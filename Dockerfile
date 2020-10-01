FROM opensuse/leap:15.1

#Install Development Tools
RUN set -eux \
    && zypper install -y make automake autoconf libpng16-devel java-11-openjdk ant zlib-devel tcl

RUN rpm -ivh https://download.opensuse.org/repositories/devel:/gcc/openSUSE_Leap_15.1/x86_64/gcc48-4.8.5-lp151.201.1.x86_64.rpm
RUN rpm -ivh https://download.opensuse.org/repositories/devel:/gcc/openSUSE_Leap_15.1/x86_64/gcc48-c++-4.8.5-lp151.201.1.x86_64.rpm
#RUN ln -sf /usr/bin/python3 /usr/bin/python
COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh

#Add user
#RUN groupadd -r griddb && useradd -r -g griddb griddb
#RUN adduser -r -u 1001 centos
#RUN useradd -r -u 1001 -g centos
#RUN usermod -aG wheel griddb
#USER root
#WORKDIR /home/griddb
#USER 1001:1001
CMD ["/bin/bash", "/docker-entrypoint.sh"]
