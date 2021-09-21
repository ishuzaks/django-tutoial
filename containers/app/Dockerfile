FROM python:3.9.7-slim-bullseye

ARG EXEC_USER=app \
    ENTRYPOINT_FILE=./containers/app/entrypoint.sh

ARG DEBIAN_FRONTEND=noninteractive

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONUTF8=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on 

RUN apt-get update && apt-get install -y \
    curl \
    netcat \
    python3-dev \
    default-libmysqlclient-dev \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt

RUN useradd --user-group --shell /sbin/nologin ${EXEC_USER} && \
    USER=${EXEC_USER} && \
    GROUP=${EXEC_USER} && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.5/fixuid-0.5-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

COPY ${ENTRYPOINT_FILE} /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER ${EXEC_USER}:${EXEC_USER}

ENTRYPOINT [ "fixuid", "entrypoint.sh"]
