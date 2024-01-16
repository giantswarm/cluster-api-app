#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# Fetches upstream Cluster API components for Kustomization.
#

# Get repository & version.
repository="$(realpath "$(dirname "${0}")/..")"
version="$(yq --exit-status ".images.tag" "${repository}/helm/cluster-api/values.yaml")"

# Fetch manifest.
curl --silent --show-error --fail --location \
  "https://github.com/giantswarm/cluster-api/releases/download/${version}/cluster-api-components.yaml" \
  --output "${repository}/config/helm/bases/cluster-api-components.yaml"
