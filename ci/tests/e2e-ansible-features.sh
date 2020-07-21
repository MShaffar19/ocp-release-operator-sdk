#!/usr/bin/env bash

set -ex

source hack/lib/test_lib.sh

header_text "Running molecule tests to check advanced Ansible features"

yum install -y \
  libffi-devel \
  openssl-devel \
  python3 \
  python3-devel \
  gcc \
  python3-pip \
  python3-setuptools

pip3 install \
  pyasn1==0.4.7 \
  pyasn1-modules==0.2.6 \
  idna==2.8 \
  ipaddress==1.0.22 \
  molecule==3.0.2 \
  ansible-lint \
  yamllint \
  docker \
  openshift \
  jmespath \
  ansible

ansible-galaxy collection install community.kubernetes

cd test/ansible
component="osdk-ansible-full-e2e"
eval OPERATOR_IMAGE=$IMAGE_FORMAT
molecule test -s cluster
