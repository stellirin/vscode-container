FROM ghcr.io/stellirin/vscode-container:golang-1.16

# Options: non-root user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG UPDATE_RC=true

# Options: node-debian.sh
ARG NODE_VERSION
ARG NVM_DIR=/usr/local/share/nvm

ARG SCRIPT_VER
ARG SCRIPT_ROOT=https://raw.githubusercontent.com/microsoft/vscode-dev-containers/$SCRIPT_VER/script-library

RUN apt-get update \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/node-debian.sh")" -- "${NVM_DIR}" "${NODE_VERSION}" "${USERNAME}" "${UPDATE_RC}" \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
