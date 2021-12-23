# Base image based on openSUSE Leap 15.3
FROM opensuse/leap:15.3
LABEL maintainer="Fabien Crespel <fabien@crespel.net>"

# Arguments
ARG CONFD_VERSION="0.16.0"
ARG CONFD_BASE_URL="https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}"

# Utilities and system users
RUN zypper in -y bzip2 curl file glibc-locale gzip iproute2 kubernetes-client less net-tools openssh rdiff tar timezone unzip w3m wget which \
	system-user-nobody system-user-wwwrun &&\
	zypper clean -a

# Confd
RUN curl -fsSL -o /usr/local/bin/confd ${CONFD_BASE_URL}/confd-${CONFD_VERSION}-linux-$(case $(uname -m) in x86_64) echo amd64 ;; aarch64) echo arm64 ;; esac) &&\
	chmod +x /usr/local/bin/confd

# Files
COPY ./root /
RUN chmod a+rw /etc/passwd /etc/group &&\
	update-ca-certificates

# Execution
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/run.sh"]
