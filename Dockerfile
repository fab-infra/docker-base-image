# Base image based on openSUSE Leap 42
FROM opensuse/leap:42
LABEL maintainer="Fabien Crespel <fabien@crespel.net>"

# Arguments
ARG CONFD_VERSION="0.16.0"
ARG CONFD_URL="https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64"

# Utilities
RUN zypper in -y bzip2 curl file glibc-locale gzip iproute2 less net-tools openssh rdiff tar timezone unzip w3m wget which &&\
	zypper clean -a

# Confd
RUN curl -fsSL -o /usr/local/bin/confd ${CONFD_URL} &&\
	chmod +x /usr/local/bin/confd

# Files
COPY ./root /
RUN chmod +x /entrypoint.sh /run.sh &&\
	chmod a+rw /etc/passwd /etc/group &&\
	update-ca-certificates

# Execution
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/run.sh"]
