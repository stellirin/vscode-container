FROM ghcr.io/stellirin/vscode-container:core

# Options: non-root user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG UPDATE_RC=true

# Options: go-debian.sh
ARG TARGET_GO_VERSION
ARG TARGET_GOROOT=/usr/local/go
ARG TARGET_GOPATH=/go
ARG INSTALL_GO_TOOLS=false

ARG SCRIPT_VER
ARG SCRIPT_ROOT=https://raw.githubusercontent.com/microsoft/vscode-dev-containers/$SCRIPT_VER/script-library

RUN apt-get update \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/go-debian.sh")" -- "${TARGET_GO_VERSION}" "${TARGET_GOROOT}" "${TARGET_GOPATH}" "${USERNAME}" "${UPDATE_RC}" "${INSTALL_GO_TOOLS}" \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
