FROM ghcr.io/stellirin/vscode-container:core

# Options: non-root user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG UPDATE_RC=true

# Options: java-debian.sh
ARG JAVA_VERSION=8.0.282.j9-adpt
ARG SDKMAN_DIR=/usr/local/sdkman

ARG SCRIPT_VER
ARG SCRIPT_ROOT=https://raw.githubusercontent.com/microsoft/vscode-dev-containers/$SCRIPT_VER/script-library

RUN apt-get update \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/java-debian.sh")" -- "${JAVA_VERSION}" "${SDKMAN_DIR}" "${USERNAME}" "${UPDATE_RC}" \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
