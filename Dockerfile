ARG BUILDER_VERSION="latest"
ARG RUNNER_VERSION="latest"

ARG BUILDER_IMAGE="ubuntu:${BUILDER_VERSION}"
ARG RUNNER_IMAGE="ubuntu:${RUNNER_VERSION}"

ARG APP_NAME="app"
ARG APP_DIR="/${APP_NAME}"

FROM ${BUILDER_IMAGE} AS builder

ARG APP_DIR

RUN apt-get update && apt-get install -y gcc make

WORKDIR ${APP_DIR}
COPY . .
RUN make build

FROM ${RUNNER_IMAGE}

ARG APP_DIR
ARG APP_NAME
ENV APP_NAME=${APP_NAME}

WORKDIR ${APP_DIR}
RUN chown nobody ${APP_DIR}

COPY --from=builder --chown=nobody:root ${APP_DIR}/${APP_NAME} .

USER nobody

CMD ./${APP_NAME}
