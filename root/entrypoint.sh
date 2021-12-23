#!/bin/sh

USER_NAME="${USER_NAME:-default}"
USER_ID=$(id -u)
GROUP_NAME="${GROUP_NAME:-default}"
GROUP_ID=$(id -g)

if ! getent passwd $USER_ID &> /dev/null && [ -w /etc/passwd ]; then
	echo "${USER_NAME}:x:${USER_ID}:${GROUP_ID}:${USER_NAME}:${HOME}:/bin/bash" >> /etc/passwd
fi
if ! getent group $GROUP_ID &> /dev/null && [ -w /etc/group ]; then
	echo "${GROUP_NAME}:x:${GROUP_ID}:" >> /etc/group
fi

exec "$@"
