#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# Removes braces breaking Helm templates from CRDs.
#

# Get repository path.
repository="$(realpath "$(dirname "${0}")/..")"

# Remove braces.
sed -Ei "" "s/({{ | }})//g" "${repository}/helm/cluster-api/files/core/patches/versions/v1beta1/clusterclasses.cluster.x-k8s.io.yaml"
