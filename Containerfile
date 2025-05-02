FROM registry.access.redhat.com/ubi9/ubi

RUN mkdir -p /opt/rapidctl/

ADD cmd /opt/rapidctl/cmd
