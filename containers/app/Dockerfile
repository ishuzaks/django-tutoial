FROM python:3.9.7-slim-bullseye

ARG EXEC_USER=app
ENV APP_HOME=/usr/src/tutorial

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
    build-essential

COPY ./requirements.txt $APP_HOME/
RUN pip install -r $APP_HOME/requirements.txt

RUN mkdir -p $APP_HOME && \
    useradd --user-group --shell /sbin/nologin $EXEC_USER

RUN USER=$EXEC_USER && \
    GROUP=$EXEC_USER && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.5/fixuid-0.5-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

COPY ./containers/app/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY ./tutorial $APP_HOME
RUN chown -R $EXEC_USER:$EXEC_USER $APP_HOME

USER $EXEC_USER:$EXEC_USER

ENTRYPOINT [ "fixuid", "entrypoint.sh"]
CMD ["gunicorn tutorial.wsgi:application --bind 0.0.0.0:8000"]
