#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# dirs
HELM_DIR="helm/cluster-api"
HELM_TEMPLATES_DIR="$HELM_DIR/templates"

move-bootstrap-manifests() {
    # move bootstrap CRDs to kustomize dir, because we are not deploying them with helm
    CRD_BASE_DIR="$HELM_DIR/files/bootstrap/bases"
    rm -f "./$CRD_BASE_DIR"/*
    mkdir -p "./$CRD_BASE_DIR"
    mv ${HELM_TEMPLATES_DIR}/apiextensions.k8s.io_v1_customresourcedefinition_*.bootstrap.cluster.x-k8s.io.yaml "./$CRD_BASE_DIR/"

    cd "$CRD_BASE_DIR"
    for crd_file in apiextensions.k8s.io_v1_customresourcedefinition_*.bootstrap.cluster.x-k8s.io.yaml; do
        new_crd_file="$(echo "$crd_file" | cut -c50-)" # remove first 50 chars
        mv "$crd_file" "$new_crd_file"
    done
    cd ../../../../..
}

move-controlplane-manifests() {
    # move control plane CRDs to kustomize dir, because we are not deploying them with helm
    CRD_BASE_DIR="$HELM_DIR/files/controlplane/bases"
    rm -f "./$CRD_BASE_DIR"/*
    mkdir -p "./$CRD_BASE_DIR"
    mv ${HELM_TEMPLATES_DIR}/apiextensions.k8s.io_v1_customresourcedefinition_*.controlplane.cluster.x-k8s.io.yaml "./$CRD_BASE_DIR/"

    cd "$CRD_BASE_DIR"
    for crd_file in apiextensions.k8s.io_v1_customresourcedefinition_*.controlplane.cluster.x-k8s.io.yaml; do
        new_crd_file="$(echo "$crd_file" | cut -c50-)" # remove first 50 chars
        mv "$crd_file" "$new_crd_file"
    done
    cd ../../../../..
}

move-core-manifests() {
    # move core plane CRDs to kustomize dir, because we are not deploying them with helm
    CRD_BASE_DIR="$HELM_DIR/files/core/bases"
    rm -f "./$CRD_BASE_DIR"/*
    mkdir -p "./$CRD_BASE_DIR"
    mv ${HELM_TEMPLATES_DIR}/apiextensions.k8s.io_v1_customresourcedefinition_*.cluster.x-k8s.io.yaml "./$CRD_BASE_DIR/"

    cd "$CRD_BASE_DIR"
    for crd_file in apiextensions.k8s.io_v1_customresourcedefinition_*.cluster.x-k8s.io.yaml; do
        new_crd_file="$(echo "$crd_file" | cut -c50-)" # remove first 50 chars
        mv "$crd_file" "$new_crd_file"
    done
    cd ../../../../..
}

move-bootstrap-manifests
move-controlplane-manifests
move-core-manifests
