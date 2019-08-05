FROM debian:10.0-slim
LABEL maintainer="kalaksi@users.noreply.github.com"

# Daemon mode starts the shatagd daemon instead of one-time check with shatag.
ENV RUN_DAEMON 0
# -r: Recurse through subdirectories
# -v: Report encountered files that have an outdated or missing checksum.
ENV SHATAGD_OPTIONS "-rv"
# -q: Do not display the valid checksums when they are found.
# -t: Compute new checksums for files that don't have one, or when it is outdated.
# -s: Recompute the checksum even if the timestamp indicates it would not be needed, and report inconsistencies. Useful to detect silent corruption.
ENV SHATAG_OPTIONS "-qtsr"

# NOTE: Here we make sure that locales are set up correctly since python/pyinotify counts on that.
# Locales will be used to determine the character encoding of filenames and in some cases
# the environment does not have the correct locale set up so shatagd will crash with
# filenames that have non-ascii characters in them.
# TODO: need to test if this is still true for the new version in Buster.
ARG SHATAG_LOCALE="en_US.UTF-8 UTF-8"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      locales \
      python3-setuptools \
      shatag && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

RUN echo "$SHATAG_LOCALE" > /etc/locale.gen && \
    locale-gen && \
    update-locale LC_ALL=$(echo "$SHATAG_LOCALE" | sed 's/\s.*//') 

# The default UID is 1000 since it's a common UID for the first user.
# Use --user with docker run or user-key with docker-compose to change it.
USER 1000:1000
CMD set -eu; \
    # Locale-settings are not read by default so doing it here.
    set -a; . /etc/default/locale; set +a; \
    if [ $RUN_DAEMON -ne 0 ]; then \
        exec python3 -u /usr/bin/shatagd $SHATAGD_OPTIONS /data; \
    else \
        exec python3 -u /usr/bin/shatag $SHATAG_OPTIONS /data; \
    fi
