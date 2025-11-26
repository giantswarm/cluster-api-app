#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# Removes braces breaking Helm templates from CRDs.
#

# Get repository path.
repository="$(realpath "$(dirname "${0}")/..")"

# Remove braces.
sed -i.bak -e "s/{{ //g" -e "s/ }}//g" "${repository}"/helm/cluster-api/charts/crd-install/files/*/patches/versions/*/*.yaml
rm -f "${repository}"/helm/cluster-api/charts/crd-install/files/*/patches/versions/*/*.yaml.bak
