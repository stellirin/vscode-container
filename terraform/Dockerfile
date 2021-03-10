FROM ghcr.io/stellirin/vscode-container:core

# Options: non-root user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG UPDATE_RC=true

# Options: terraform-debian.sh
ARG TERRAFORM_VERSION
ARG TFLINT_VERSION=latest

ARG SCRIPT_VER
ARG SCRIPT_ROOT=https://raw.githubusercontent.com/microsoft/vscode-dev-containers/$SCRIPT_VER/script-library

RUN apt-get update \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/kubectl-helm-debian.sh")" \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/terraform-debian.sh")" -- "${TERRAFORM_VERSION}" "${TFLINT_VERSION}" \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get update \
    && apt-get install -y \
    google-cloud-sdk \
    python3-requests \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
