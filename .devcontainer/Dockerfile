FROM ubuntu:focal

# Options: non-root user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG UPDATE_RC=true

# Options: common-debian.sh
ARG INSTALL_ZSH=true
ARG UPGRADE_PACKAGES=false
ARG INSTALL_OH_MYS=true

# Options: docker-debian.sh
ARG ENABLE_NONROOT_DOCKER=true
ARG SOURCE_SOCKET=/var/run/docker-host.sock
ARG TARGET_SOCKET=/var/run/docker.sock

# Options: go-debian.sh
ARG TARGET_GO_VERSION
ARG TARGET_GOROOT=/usr/local/go
ARG TARGET_GOPATH=/go
ARG INSTALL_GO_TOOLS=false

# Options: java-debian.sh
ARG JAVA_VERSION=8.0.282.j9-adpt
ARG SDKMAN_DIR=/usr/local/sdkman

# Options: node-debian.sh
ARG NODE_VERSION
ARG NVM_DIR=/usr/local/share/nvm

# Options: rust-debian.sh
ARG CARGO_HOME=/usr/local/cargo
ARG RUSTUP_HOME=/usr/local/rustup
ARG UPDATE_RUST=false

# Options: terraform-debian.sh
ARG TERRAFORM_VERSION
ARG TFLINT_VERSION=latest

ARG SCRIPT_VER
ARG SCRIPT_ROOT=https://raw.githubusercontent.com/microsoft/vscode-dev-containers/$SCRIPT_VER/script-library

RUN apt-get update \
 && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
 && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/common-debian.sh")" -- "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "${INSTALL_OH_MYS}" \
 && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/docker-debian.sh")" -- "${ENABLE_NONROOT_DOCKER}" "${SOURCE_SOCKET}" "${TARGET_SOCKET}" "${USERNAME}" \
 && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/kubectl-helm-debian.sh")" \
 && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/go-debian.sh")" -- "${TARGET_GO_VERSION}" "${TARGET_GOROOT}" "${TARGET_GOPATH}" "${USERNAME}" "${UPDATE_RC}" "${INSTALL_GO_TOOLS}" \
 && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/java-debian.sh")" -- "${JAVA_VERSION}" "${SDKMAN_DIR}" "${USERNAME}" "${UPDATE_RC}" \
 && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/node-debian.sh")" -- "${NVM_DIR}" "${NODE_VERSION}" "${USERNAME}" "${UPDATE_RC}" \
 && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/rust-debian.sh")" -- "${CARGO_HOME}" "${RUSTUP_HOME}" "${USERNAME}" "${UPDATE_RC}" "${UPDATE_RUST}" \
 && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/terraform-debian.sh")" -- "${TERRAFORM_VERSION}" "${TFLINT_VERSION}" \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /home/vscode/.config \
 && chown -R vscode:vscode /home/vscode/.config \
 && mkdir -p /home/vscode/.vscode-server/extensions \
 && chown -R vscode:vscode /home/vscode/.vscode-server

# Setting the ENTRYPOINT to docker-init.sh will configure non-root access to
# the Docker socket if "overrideCommand": false is set in devcontainer.json.
# The script will also execute CMD if you need to alter startup behaviors.
ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD [ "sleep", "infinity" ]

# Used by many dev environments for Google auth
RUN apt-get update \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
 && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
 && apt-get update \
 && apt-get install -y \
    google-cloud-sdk \
    python3-requests \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/*

# Used in Terraform scripts
RUN wget https://storage.googleapis.com/oauth2l/latest/linux_amd64.tgz \
 && tar zxvf linux_amd64.tgz \
 && mv linux_amd64/oauth2l /usr/local/bin/ \
 && rm -rf linux_amd64 linux_amd64.tgz

ARG TINY_GO_VERSION=0.19.0
RUN apt-get update \
    && wget https://github.com/tinygo-org/tinygo/releases/download/v${TINY_GO_VERSION}/tinygo_${TINY_GO_VERSION}_amd64.deb \
    && dpkg -i tinygo_${TINY_GO_VERSION}_amd64.deb \
    && rm -f tinygo_${TINY_GO_VERSION}_amd64.deb

# # Used for WebAssembly development
# RUN apt-get update \
#  && curl -sL 'https://getenvoy.io/gpg' | sudo gpg --dearmor -o /usr/share/keyrings/getenvoy-keyring.gpg \
#  && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/getenvoy-keyring.gpg] https://dl.bintray.com/tetrate/getenvoy-deb $(lsb_release -cs) stable" > /etc/apt/sources.list.d/getenvoy.list \
#  && apt-get update \
#  && sudo apt-get install -y \
#     getenvoy-envoy \
#  && apt-get clean -y \
#  && rm -rf /var/lib/apt/lists/*
