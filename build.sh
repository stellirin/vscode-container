#!/bin/bash

SCRIPT_VER=v0.184.0

docker pull ubuntu:focal

docker build \
    --file=core/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --tag=ghcr.io/stellirin/vscode-container:core .

docker build \
    --file=golang/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --build-arg=TARGET_GO_VERSION=1.16.5 \
    --tag=ghcr.io/stellirin/vscode-container:golang-1.16 .

docker build \
    --file=node/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --build-arg=NODE_VERSION=14.17.1 \
    --tag=ghcr.io/stellirin/vscode-container:node-14 .

docker build \
    --file=golang+node/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --build-arg=NODE_VERSION=14.17.1 \
    --tag=ghcr.io/stellirin/vscode-container:golang-1.16_node-14 .

docker build \
    --file=terraform/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --build-arg=TERRAFORM_VERSION=0.14.7 \
    --tag=ghcr.io/stellirin/vscode-container:terraform-0.14.7 .

docker build \
    --file=java/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --build-arg=JAVA_VERSION=8.0.282.j9-adpt \
    --tag=ghcr.io/stellirin/vscode-container:java-8 .
