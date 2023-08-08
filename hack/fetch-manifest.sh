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
org="giantswarm"
repo="cluster-api"
version="$(yq e -e '.images.tag' "$helm_values")" || { >&2 echo "Could not find image tag value"; exit 1; }
release_asset_filename="cluster-api-components.yaml"
url="https://github.com/$org/$repo/releases/download/$version/${release_asset_filename}"
mkdir -p "$KUSTOMIZE_INPUT_DIR"
curl -fsSL "$url" -o "$KUSTOMIZE_INPUT_DIR/${release_asset_filename}" || { >&2 echo "Failed to get release manifest from $url"; exit 1; }
