FROM ubuntu:focal

# Options: non-root user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ARG SCRIPT_VER=v0.161.0
ARG SCRIPT_ROOT=https://raw.githubusercontent.com/microsoft/vscode-dev-containers/$SCRIPT_VER/script-library

# Options: common-debian.sh
ARG INSTALL_ZSH=true
ARG UPGRADE_PACKAGES=false
ARG INSTALL_OH_MYS=true

# Options: docker-debian.sh
ARG ENABLE_NONROOT_DOCKER=true
ARG SOURCE_SOCKET=/var/run/docker-host.sock
ARG TARGET_SOCKET=/var/run/docker.sock

# Options: go-debian.sh
ARG TARGET_GO_VERSION=1.16
ARG TARGET_GOROOT=/usr/local/go
ARG TARGET_GOPATH=/go
ARG UPDATE_RC=true
ARG INSTALL_GO_TOOLS=false

# Options: github-debian.sh
ARG CLI_VERSION=latest

# Options: terraform-debian.sh
ARG TERRAFORM_VERSION=0.14.7
ARG TFLINT_VERSION=latest

RUN apt-get update \
    && apt-get install -y \
    curl \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/common-debian.sh")" -- "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "${INSTALL_OH_MYS}" \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/docker-debian.sh")" -- "${ENABLE_NONROOT_DOCKER}" "${SOURCE_SOCKET}" "${TARGET_SOCKET}" "${USERNAME}" \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/go-debian.sh")" -- "${TARGET_GO_VERSION}" "${TARGET_GOROOT}" "${TARGET_GOPATH}" "${USERNAME}" "${UPDATE_RC}" "${INSTALL_GO_TOOLS}" \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/github-debian.sh")" -- "${CLI_VERSION}" \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/kubectl-helm-debian.sh")" \
    && bash -c "$(curl -fsSL "${SCRIPT_ROOT}/terraform-debian.sh")" -- "${TERRAFORM_VERSION}" "${TFLINT_VERSION}" \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get update \
    && apt-get install -y \
    google-cloud-sdk \
    python3-requests \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /home/vscode/.vscode-server/extensions \
    && chown -R vscode:vscode /home/vscode/.vscode-server

# Setting the ENTRYPOINT to docker-init.sh will configure non-root access to
# the Docker socket if "overrideCommand": false is set in devcontainer.json.
# The script will also execute CMD if you need to alter startup behaviors.
ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD [ "sleep", "infinity" ]
