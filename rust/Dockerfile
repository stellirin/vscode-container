FROM ghcr.io/stellirin/vscode-container:core

# Options: non-root user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG UPDATE_RC=true

# Options: rust-debian.sh
ARG CARGO_HOME=/usr/local/cargo
ARG RUSTUP_HOME=/usr/local/rustup
ARG UPDATE_RUST=false

ARG SCRIPT_VER
ARG SCRIPT_ROOT=https://raw.githubusercontent.com/microsoft/vscode-dev-containers/$SCRIPT_VER/script-library

RUN apt-get update \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/rust-debian.sh")" -- "${CARGO_HOME}" "${RUSTUP_HOME}" "${USERNAME}" "${UPDATE_RC}" "${UPDATE_RUST}" \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common \
    && curl -sL 'https://getenvoy.io/gpg' | sudo apt-key add - \
    && add-apt-repository \
        "deb [arch=amd64] https://dl.bintray.com/tetrate/getenvoy-deb \
        $(lsb_release -cs) \
        stable" \
    && apt-get update \
    && sudo apt-get install -y \
        getenvoy-envoy \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
