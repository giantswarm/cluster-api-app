#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# Moves CRDs from the chart's templates to their component's bases.
#

# Get repository path.
repository="$(realpath "$(dirname "${0}")/..")"

# Iterate components.
# Core is last as it has no prefix and matches all CRDs.
for component in "bootstrap" "controlplane" "core"
do
    # Get component prefix.
    [ "${component}" != "core" ] && prefix="${component}." || prefix=""

    # Remove existing CRDs.
    rm -f "${repository}/helm/cluster-api/charts/crd-install/files/${component}/bases/"*".yaml"

    # Iterate generated CRDs.
    for crd_path in "${repository}/helm/cluster-api/templates/apiextensions.k8s.io_v1_customresourcedefinition_"*".${prefix}cluster.x-k8s.io.yaml"
    do
        # Get & shorten CRD file name.
        crd_file="$(basename "${crd_path}")"
        crd_file="${crd_file#apiextensions.k8s.io_v1_customresourcedefinition_}"

        # Move generated CRD.
        mv "${crd_path}" "${repository}/helm/cluster-api/charts/crd-install/files/${component}/bases/${crd_file}"
    done
done
