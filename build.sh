#!/bin/bash

SCRIPT_VER=v0.187.0

docker pull ubuntu:focal

docker build \
    --file=.devcontainer/Dockerfile \
    --build-arg=SCRIPT_VER=${SCRIPT_VER} \
    --build-arg=TARGET_GO_VERSION=1.16.6 \
    --build-arg=JAVA_VERSION=8.0.282.j9-adpt \
    --build-arg=NODE_VERSION=14.17.3 \
    --build-arg=TERRAFORM_VERSION=1.0.1 \
    --tag=ghcr.io/stellirin/vscode-container:latest .
