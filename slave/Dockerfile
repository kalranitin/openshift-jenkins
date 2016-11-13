# The FROM will be replaced when building in OpenShift
FROM openshift/base-centos7

ENV HOME=/home/jenkins
USER root

RUN yum install -y --setopt=tsflags=nodocs --enablerepo=centosplus epel-release && \
    rpmkeys --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 && \
    yum install -y --setopt=tsflags=nodocs install bc gettext git java-1.8.0-openjdk-headless lsof nss_wrapper rsync tar unzip which zip service wget && \
    yum clean all && \
    mkdir -p /home/jenkins && \
    chown -R 1001:0 /home/jenkins && \
    chmod -R g+w /home/jenkins && \
    curl -L https://github.com/openshift/origin/releases/download/v1.2.1/openshift-origin-client-tools-v1.2.1-5e723f6-linux-64bit.tar.gz | tar -zx && \
    mv openshift*/oc /usr/local/bin && \
    rm -rf openshift-origin-client-tools-*

# Copy the entrypoint
ADD contrib/bin/* /usr/local/bin/


WORKDIR /tmp

RUN wget --no-cookies --no-check-certificate https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-1.10.3-1.el7.centos.x86_64.rpm && \
	wget --no-cookies --no-check-certificate https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-selinux-1.10.3-1.el7.centos.noarch.rpm && \
	yum -y install /tmp/docker-engine-selinux-1.10.3-1.el7.centos.noarch.rpm && rm /tmp/docker-engine-selinux-1.10.3-1.el7.centos.noarch.rpm && \
	yum -y install /tmp/docker-engine-1.10.3-1.el7.centos.x86_64.rpm && rm /tmp/docker-engine-1.10.3-1.el7.centos.x86_64.rpm

RUN chown -R 1001:0 $HOME && chmod -R g+rw $HOME

WORKDIR /home/jenkins

# Cannot run as user 1001 as it needs connection with docker daemon	
#USER 1001

# Run the Jenkins JNLP client
ENTRYPOINT ["/usr/local/bin/run-jnlp-client"]
