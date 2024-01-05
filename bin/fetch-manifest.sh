#!/usr/bin/env bash

#
# Fetches upstream `cluster-api-components.yaml` as basis for kustomization.
#

# Exit on error.
set -o errexit -o nounset -o pipefail

# Get repository & version.
repository="$(dirname "${0}")/.."
version="$(yq --exit-status ".images.tag" "${repository}/helm/cluster-api/values.yaml")"

# Fetch manifest.
curl --silent --show-error --fail --location \
  "https://github.com/giantswarm/cluster-api/releases/download/${version}/cluster-api-components.yaml" \
  --output "${repository}/manifests/cluster-api-components.yaml"
