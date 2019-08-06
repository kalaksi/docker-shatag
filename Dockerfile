FROM debian:10.0-slim AS base
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


FROM base AS builder
# Revision number from commit history of shatag source
ARG SOURCE_REVISION="213"

# The package in Debian Buster is borked. Building the most recent version from source.
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
      build-essential \
      libyaml-dev \
      mercurial \
      python3-dev \
      python3-pip \
      python3-setuptools \
      python3-venv
RUN cd /opt && \
    hg clone https://bitbucket.org/maugier/shatag -r "$SOURCE_REVISION" && \
    cd shatag && \
    python3 -m venv venv && \
    ./venv/bin/python setup.py install


FROM base
# NOTE: Here we make sure that locales are set up correctly since python/pyinotify counts on that.
# Locales will be used to determine the character encoding of filenames and in some cases
# the environment does not have the correct locale set up so shatagd will crash and burn with
# filenames that have non-ascii characters in them.
# TODO: need to test if this is still true for the new version.
ARG SHATAG_LOCALE="en_US.UTF-8 UTF-8"

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
      locales \
      python3-setuptools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists
RUN echo "$SHATAG_LOCALE" > /etc/locale.gen && \
    locale-gen && \
    update-locale LC_ALL=$(echo "$SHATAG_LOCALE" | sed 's/\s.*//') 

COPY --from=builder /opt/ /opt/

# The default UID is 1000 since it's a common UID for the first user.
# Use --user with docker run or user-key with docker-compose to change it.
USER 1000:1000
CMD set -eu; \
    # Locale-settings are not read by default so doing it here.
    set -a; . /etc/default/locale; set +a; \
    if [ $RUN_DAEMON -ne 0 ]; then \
        exec /opt/shatag/venv/bin/shatagd $SHATAGD_OPTIONS /data; \
    else \
        exec /opt/shatag/venv/bin/shatag $SHATAG_OPTIONS /data; \
    fi
