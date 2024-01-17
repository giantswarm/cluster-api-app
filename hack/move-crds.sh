#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# Moves CRDs from the chart's templates to their component's bases.
#

# Get repository.
repository="$(realpath "$(dirname "${0}")/..")"

# Iterate components.
# Core is last as it has no prefix and matches all CRDs.
for component in "bootstrap" "controlplane" "core"
do
    # Get prefix.
    [ "${component}" != "core" ] && prefix="${component}." || prefix=""

    # Remove CRDs.
    rm "${repository}/helm/cluster-api/files/${component}/bases/"*".yaml"

    # Iterate CRDs.
    for path in "${repository}/helm/cluster-api/templates/apiextensions.k8s.io_v1_customresourcedefinition_"*".${prefix}cluster.x-k8s.io.yaml"
    do
        # Get & shorten file.
        file="$(basename "${path}")"
        file="${file#apiextensions.k8s.io_v1_customresourcedefinition_}"

        # Move file.
        mv "${path}" "${repository}/helm/cluster-api/files/${component}/bases/${file}"
    done
done
