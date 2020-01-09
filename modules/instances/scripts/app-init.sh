#!/bin/bash

set -ex

# update
apt-get update

export DEBIAN_FRONTEND=noninteractive
apt-get -y upgrade
