# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.231.5/containers/debian/.devcontainer/base.Dockerfile

# [Choice] Debian version (use bullseye on local arm64/Apple Silicon): bullseye, buster
ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# ** [Optional] Uncomment this section to install additional packages. **
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends dh-make quilt fakeroot \
    build-essential

RUN wget https://go.dev/dl/go1.18.linux-amd64.tar.gz && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf go1.18.linux-amd64.tar.gz \
    && echo 'export PATH=$PATH:/usr/local/go/bin' >> /home/vscode/.profile

COPY .bashrc /home/vscode/.bashrc
COPY .quiltrc-dpkg /home/vscode/.quiltrc-dpkg