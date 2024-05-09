#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# The CRD contains some templates in the descriptions and 
# those break our helm templates. This script removes the
# curly braces from the CRD.
#

# Get repository path.
repository="$(realpath "$(dirname "${0}")/..")"


sed -i.bak -e 's/{{ //g' -e 's/ }}//g'  "${repository}/helm/cluster-api/files/core/patches/versions/v1beta1/clusterclasses.cluster.x-k8s.io.yaml"
rm "${repository}/helm/cluster-api/files/core/patches/versions/v1beta1/clusterclasses.cluster.x-k8s.io.yaml.bak"
