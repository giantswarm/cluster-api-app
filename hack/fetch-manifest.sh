#!/usr/bin/env bash

# This script fetch upstream release `cluster-api-components.yaml` which is later used to apply
# all kustomize patches

set -o errexit
set -o nounset
set -o pipefail

# Directories
ROOT_DIR="./$(dirname "$0")/.."
ROOT_DIR="$(realpath "$ROOT_DIR")"
HELM_DIR="$ROOT_DIR/helm/cluster-api"
KUSTOMIZE_INPUT_DIR="$ROOT_DIR/config/helm/input"

# Download upstream manifests
helm_values="$HELM_DIR/values.yaml"
# Giant Swarm specific, since we don't use GitHub releases in https://github.com/giantswarm/cluster-api
version="$(yq e -e '.images.tag' "$helm_values")" || { echo "Could not find image tag value"; exit 1; }
release_asset_filename="cluster-api-components.yaml"
mkdir -p "$KUSTOMIZE_INPUT_DIR"
# Image does not have a shell or `cat` installed, so extract the file using busybox
empty_context="$(mktemp -d)"
cat >"${empty_context}/Dockerfile.manifest" <<EOF
FROM docker.io/giantswarm/cluster-api-controller:${version} as src
FROM docker.io/library/busybox:1
COPY --from=src /for-cluster-api-app-only/cluster-api-components.yaml /file
EOF
docker build -f "${empty_context}/Dockerfile.manifest" -t manifest "${empty_context}"
rm -r "${empty_context}"
docker run --rm manifest cat /file >"$KUSTOMIZE_INPUT_DIR/$release_asset_filename"
[ "$(grep -c ^ "$KUSTOMIZE_INPUT_DIR/$release_asset_filename")" -gt 20000 ] || { >&2 echo "Downloaded ${release_asset_filename} does not seem right"; exit 1; }
