FROM        docker.io/centos:latest

USER        root

RUN         yum update -y && \
            yum install -y --setopt=tsflags=nodocs git yum-utils unzip golang bzr && \
            yum -y clean all && \
            rm -rf /var/cache/yum && \
            go get github.com/coreos/clair && \
            go install github.com/coreos/clair/cmd/clair && \
            mkdir /clair && \
            mkdir /clair/config && \
            touch /clair/config/config.yaml && \
            mkdir /clair/bin && \
            chmod 770 /clair && \
            cp /root/go/bin/clair /clair/bin/

ADD         config/config.yaml.template /clair/config/
ADD         scripts/run-clair.sh /clair/bin/

RUN         chmod 660 /clair/config/config.yaml.template && \
            chmod 660 /clair/config/config.yaml && \
            chmod 660 /clair/bin/run-clair.sh && \
            chmod a+x /clair/bin/run-clair.sh

ENTRYPOINT ["/clair/bin/run-clair.sh"]

