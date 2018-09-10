FROM debian:stretch-slim
MAINTAINER Kalaksi <kalaksi@users.noreply.github.com>

# Daemon mode starts the shatagd daemon instead of one-time check with shatag.
ENV SHATAG_RUN_DAEMON 0
ENV SHATAGD_OPTIONS "-rv"
ENV SHATAG_OPTIONS "-qftr"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      shatag && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

# The default UID is 1000 since it's a common UID for the first user.
# Use --user with docker run or user-key with docker-compose to change it.
USER 1000:1000
ENTRYPOINT set -eu; \
           if [ $SHATAG_RUN_DAEMON -ne 0 ]; then \
               exec python3 -u /usr/bin/shatagd $SHATAGD_OPTIONS /data; \
           else \
               exec python3 -u /usr/bin/shatag $SHATAG_OPTIONS /data; \
           fi
