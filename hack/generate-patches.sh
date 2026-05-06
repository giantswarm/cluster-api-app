#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# Generates CRD patches.
#

# Get repository path.
repository="$(realpath "$(dirname "${0}")/..")"

# Iterate components.
for component in "core" "bootstrap" "controlplane"
do
    # Define kustomization & directories.
    kustomization="${repository}/helm/cluster-api/charts/crd-install/files/${component}/kustomization.yaml"
    bases="${repository}/helm/cluster-api/charts/crd-install/files/${component}/bases"
    patches="${repository}/helm/cluster-api/charts/crd-install/files/${component}/patches"

    # Reset kustomization.
    yq --inplace ".resources = [] | .patches = []" "${kustomization}"

    # Remove old patches.
    rm -rf "${patches}"/*

    # Iterate CRDs.
    for crd in "${bases}"/*.yaml
    do
        # Define CRD name & file.
        crd_name="$(yq ".metadata.name" "${crd}")"
        crd_file="$(basename "${crd}")"

        # Add CRD.
        yq --inplace ".resources += [\"bases/${crd_file}\"]" "${kustomization}"

        # Define index.
        index=0

        # Iterate versions.
        for version in $(yq ".spec.versions[].name" "${crd}")
        do
            # Create patch.
            mkdir -p "${patches}/${version}"
            cat > "${patches}/${version}/${crd_file}" << EOF
- op: replace
  path: /spec/versions/${index}/schema
  value:
EOF
            # Transfer schema.
            yq ".spec.versions[${index}].schema" "${crd}" > "${patches}/${version}/${crd_file}.schema"
            yq --inplace ".[0].value = load(\"${patches}/${version}/${crd_file}.schema\")" "${patches}/${version}/${crd_file}"
            rm "${patches}/${version}/${crd_file}.schema"
            yq --inplace ".spec.versions[${index}].schema = {}" "${crd}"

            # Add patch.
            patch="path: patches/${version}/${crd_file}
target:
    group: apiextensions.k8s.io
    version: v1
    kind: CustomResourceDefinition
    name: ${crd_name}
" yq --inplace ".patches += [env(patch)]" "${kustomization}"

            # Increment index.
            index=$((index + 1))
        done
    done
done
