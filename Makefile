# Makefile for Podman + Docker Compose setup with dynamic version

LATEST_VERSION := $(shell curl -s https://github.com/docker/compose/releases | grep -oP 'v\d+\.\d+\.\d+' | head -n 1)
VERSION := $(shell echo $(LATEST_VERSION) | sed 's/^v//')
DOCKER_COMPOSE_URL = https://github.com/docker/compose/releases/download/$(LATEST_VERSION)/docker-compose-$(shell uname -s)-$(shell uname -m)
DOCKER_COMPOSE_BIN = /usr/local/bin/docker-compose
DOCKER_HOST_LINE = export DOCKER_HOST=unix:///run/user/$$UID/podman/podman.sock

.PHONY: all update install_podman install_podman_docker install_docker_compose enable_podman_socket set_docker_host

all: update install_podman install_podman_docker install_docker_compose enable_podman_socket set_docker_host

update:
        sudo dnf update -y

install_podman:
        sudo dnf install podman -y
        podman --version

install_podman_docker:
        sudo dnf install podman-docker -y

install_docker_compose:
        @echo "Downloading Docker Compose version $(VERSION) from $(DOCKER_COMPOSE_URL)"
        sudo curl -L "$(DOCKER_COMPOSE_URL)" -o $(DOCKER_COMPOSE_BIN)
        sudo chmod +x $(DOCKER_COMPOSE_BIN)

enable_podman_socket:
        systemctl --user enable --now podman.socket
        systemctl --user status podman.socket

set_docker_host:
        @echo '$(DOCKER_HOST_LINE)'
        @grep -qxF '$(DOCKER_HOST_LINE)' ~/.bashrc || echo '$(DOCKER_HOST_LINE)' >> ~/.bashrc
        @echo "Added DOCKER_HOST to ~/.bashrc if not present."
