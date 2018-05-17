FROM        registry.access.redhat.com/rhel7:latest

USER        root

RUN         rpm --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release && \
            yum-config-manager --disable "*" && \
            yum-config-manager --enable rhel-7-server-rpms && \
            yum update-minimal -y --security --sec-severity=Important --sec-severity=Critical --setopt=tsflags=nodocs && \
            yum install -y --setopt=tsflags=nodocs git yum-utils unzip golang bzr --enablerepo=rhel-7-server-optional-rpms && \
            yum -y clean all && \
            rm -rf /var/cache/yum && \
            go get github.com/coreos/clair && \
            go install github.com/coreos/clair/cmd/clair && \
            mkdir /clair && \
            mkdir /clair/config && \
            touch /clair/config/config.yaml && \
            mkdir /clair/bin && \
            chmod 770 /clair && \
            mv /root/go/bin/clair /clair/bin/ && \
            rm -rf /root/go

ADD         config/config.yaml.template /clair/config/
ADD         scripts/run-clair.sh /clair/bin/

RUN         chmod 660 /clair/config/config.yaml.template && \
            chmod 660 /clair/config/config.yaml && \
            chmod 660 /clair/bin/run-clair.sh && \
            chmod a+x /clair/bin/run-clair.sh

ENTRYPOINT ["/clair/bin/run-clair.sh"]

