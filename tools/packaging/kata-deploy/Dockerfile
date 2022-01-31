# Copyright Intel Corporation.
#
# SPDX-License-Identifier: Apache-2.0

FROM centos:7 AS base

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*; \
rm -f /etc/systemd/system/*.wants/*; \
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*; \
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]

FROM base

ARG KUBE_ARCH=amd64
ARG KATA_VER=2.3.0
ARG KATA_ARTIFACTS=kata-static-${KATA_VER}-x86_64.tar.xz
ARG DESTINATION=/opt/kata-artifacts

ADD https://github.com/kata-containers/kata-containers/releases/download/${KATA_VER}/${KATA_ARTIFACTS} .
COPY ./local-build/build/kata-static-kernel-tdx.tar.xz /tmp/tdx/
COPY ./local-build/build/kata-static-shim-v2.tar.xz /tmp/tdx/

RUN \
yum -y update && \
yum install -y epel-release && \
yum install -y bzip2 jq && \
yum clean all && \
mkdir -p ${DESTINATION} && \
tar xvf ${KATA_ARTIFACTS} -C ${DESTINATION}/ && \
chown -R root:root ${DESTINATION}/

RUN \
for f in `ls /tmp/tdx/`; do \
tar xvf /tmp/tdx/$f -C ${DESTINATION}/; \
done && \
rm -rf /tmp/tdx/ && \
chown -R root:root ${DESTINATION}/

RUN \
curl -Lso /bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/${KUBE_ARCH}/kubectl && \
chmod +x /bin/kubectl

COPY scripts ${DESTINATION}/scripts
RUN \
ln -s ${DESTINATION}/scripts/kata-deploy.sh /usr/bin/kata-deploy
