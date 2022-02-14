#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# dirs
HELM_DIR="helm/cluster-api"
HELM_TEMPLATES_DIR="$HELM_DIR/templates"

move-bootstrap-manifests() {
    cd "$HELM_TEMPLATES_DIR"
    mkdir -p bootstrap

    # move all other bootstrap manifests
    mv ./*capi-kubeadm-bootstrap*.yaml bootstrap/

    # rename deployment manifest
    mv bootstrap/apps_v1_deployment_capi-kubeadm-bootstrap-controller-manager.yaml bootstrap/deployment.yaml

    # rename RBAC manifests
    mv bootstrap/rbac.authorization.k8s.io_v1_clusterrole_capi-kubeadm-bootstrap-manager-role.yaml bootstrap/role.yaml
    mv bootstrap/rbac.authorization.k8s.io_v1_clusterrolebinding_capi-kubeadm-bootstrap-manager-rolebinding.yaml bootstrap/rolebinding.yaml

    # rename service manifest
    mv bootstrap/v1_service_capi-kubeadm-bootstrap-webhook-service.yaml bootstrap/service.yaml

    # rename certificate manifest
    mv bootstrap/cert-manager.io_v1_certificate_capi-kubeadm-bootstrap-serving-cert.yaml bootstrap/certificate.yaml

    # rename webhook configuration manifest
    mv bootstrap/admissionregistration.k8s.io_v1beta1_validatingwebhookconfiguration_capi-kubeadm-bootstrap-validating-webhook-configuration.yaml bootstrap/validatingwebhookconfiguration.yaml

    # go back to root
    cd ../../..

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
    cd "$HELM_TEMPLATES_DIR"
    mkdir -p controlplane

    # move all control plane manifests
    mv ./*capi-kubeadm-control-plane*.yaml controlplane/

    # rename deployment manifest
    mv controlplane/apps_v1_deployment_capi-kubeadm-control-plane-controller-manager.yaml controlplane/deployment.yaml

    # rename RBAC manifests
    mv controlplane/rbac.authorization.k8s.io_v1_clusterrole_capi-kubeadm-control-plane-manager-role.yaml controlplane/role.yaml
    mv controlplane/rbac.authorization.k8s.io_v1_clusterrolebinding_capi-kubeadm-control-plane-manager-rolebinding.yaml controlplane/rolebinding.yaml

    # rename service manifest
    mv controlplane/v1_service_capi-kubeadm-control-plane-webhook-service.yaml controlplane/service.yaml

    # rename certificate manifest
    mv controlplane/cert-manager.io_v1_certificate_capi-kubeadm-control-plane-serving-cert.yaml controlplane/certificate.yaml

    # rename webhook configurations manifests
    mv controlplane/admissionregistration.k8s.io_v1beta1_mutatingwebhookconfiguration_zzz-capi-kubeadm-control-plane-mutating-webhook-configuration.yaml controlplane/mutatingwebhookconfiguration.yaml
    mv controlplane/admissionregistration.k8s.io_v1beta1_validatingwebhookconfiguration_capi-kubeadm-control-plane-validating-webhook-configuration.yaml controlplane/validatingwebhookconfiguration.yaml

    # go back to root
    cd ../../..

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
    cd "$HELM_TEMPLATES_DIR"
    mkdir -p core

    # move all other core manifests
    mv ./*capi*.yaml core/

    # rename deployment manifest
    mv core/apps_v1_deployment_capi-controller-manager.yaml core/deployment.yaml

    # rename RBAC manifests
    mv core/rbac.authorization.k8s.io_v1_clusterrole_capi-manager-role.yaml core/role.yaml
    mv core/rbac.authorization.k8s.io_v1_clusterrolebinding_capi-manager-rolebinding.yaml core/rolebinding.yaml

    # rename service manifest
    mv core/v1_service_capi-webhook-service.yaml core/service.yaml

    # rename certificate manifest
    mv core/cert-manager.io_v1_certificate_capi-serving-cert.yaml core/certificate.yaml

    # rename webhook configuration manifests
    mv core/admissionregistration.k8s.io_v1beta1_mutatingwebhookconfiguration_zzz-capi-mutating-webhook-configuration.yaml core/mutatingwebhookconfiguration.yaml
    mv core/admissionregistration.k8s.io_v1beta1_validatingwebhookconfiguration_capi-validating-webhook-configuration.yaml core/validatingwebhookconfiguration.yaml

    # go back to root
    cd ../../..

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
