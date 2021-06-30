FROM ghcr.io/stellirin/vscode-container:golang-1.16

# Options: non-root user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG UPDATE_RC=true

# Options: node-debian.sh
ARG NODE_VERSION
ARG NVM_DIR=/usr/local/share/nvm

# Options: terraform-debian.sh
ARG TERRAFORM_VERSION
ARG TFLINT_VERSION=latest

ARG SCRIPT_VER
ARG SCRIPT_ROOT=https://raw.githubusercontent.com/microsoft/vscode-dev-containers/$SCRIPT_VER/script-library

RUN apt-get update \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/node-debian.sh")" -- "${NVM_DIR}" "${NODE_VERSION}" "${USERNAME}" "${UPDATE_RC}" \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get update \
    && apt-get install -y \
    google-cloud-sdk \
    python3-requests \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://storage.googleapis.com/oauth2l/latest/linux_amd64.tgz \
    && tar zxvf linux_amd64.tgz \
    && mv linux_amd64/oauth2l /usr/local/bin/ \
    && rm -rf linux_amd64 linux_amd64.tgz