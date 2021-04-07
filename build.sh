#!/bin/bash

SCRIPT_VER=v0.166.1

docker pull ubuntu:focal

docker build \
    --file=core/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --tag=ghcr.io/stellirin/vscode-container:core .

docker build \
    --file=golang/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --build-arg=TARGET_GO_VERSION=1.16.3 \
    --tag=ghcr.io/stellirin/vscode-container:golang-1.16 .

docker build \
    --file=node/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --build-arg=NODE_VERSION=12.18.2 \
    --tag=ghcr.io/stellirin/vscode-container:node-12 .

docker build \
    --file=node/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --build-arg=NODE_VERSION=14.16.0 \
    --tag=ghcr.io/stellirin/vscode-container:node-14 .

docker build \
    --file=golang+node/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --build-arg=NODE_VERSION=14.16.0 \
    --tag=ghcr.io/stellirin/vscode-container:golang-1.16_node-14 .

docker build \
    --file=terraform/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --build-arg=TERRAFORM_VERSION=0.14.7 \
    --tag=ghcr.io/stellirin/vscode-container:terraform-0.14.7 .
