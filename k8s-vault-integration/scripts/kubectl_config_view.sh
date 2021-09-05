#!/bin/bash

set -e
# Extract cluster_name from the input
eval "$(jq -r '@sh "CLUSTER=\(.cluster_name) KUBECONFIG=\(.kubeconfig_path)"')"
export KUBECONFIG
# The output should contain two keys:
# - "server" - API URL
# - "certificate-authority-data" - base64-encoded CA certificate
kubectl config view --raw -ojson | jq -r ".clusters[] | select(.name == \"${CLUSTER}\") | .cluster"
