#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# The CRD contains some templates in the descriptions breaking our Helm templates.
# This script removes the curly braces from the CRD.
#

# Get repository path.
repository="$(realpath "$(dirname "${0}")/..")"

# Remove braces.
sed -Ei "" "s/({{ | }})//g" "${repository}/helm/cluster-api/files/core/patches/versions/v1beta1/clusterclasses.cluster.x-k8s.io.yaml"
