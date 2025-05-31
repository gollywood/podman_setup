# podman_setup
Script for quickly setting up a rootless podman compose with the newest docker compose version that works on AlmaLinux OS.

# How to use:
## Requirements
 
 - dnf as package manager 
 - git installed
 - make installed

## Step 1:
Add a user (e.g.) podman:

    adduser podman
    passwd <SET A SWEET PASSWORD NO ONE WILL EVER KNOW>
    usermod -aG wheel podmanmgmt

## Step 2
connect to the user via ssh - this is important to aviod annoying impersonation issues etc... it gives you a full shell in context of the user

     ssh podman@localhost

## Step 3
Download the Makefile and execute it

    git clone https://github.com/gollywood/podman_setup
    cd podman_setup
    make

## Step 4
Test it

    podman compose version
