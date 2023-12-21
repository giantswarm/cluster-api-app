[![CircleCI](https://circleci.com/gh/giantswarm/cluster-api-app.svg?style=shield)](https://circleci.com/gh/giantswarm/cluster-api-app)

# cluster-api chart

This is a meta App that provides deployment packaging for Cluster API core, bootstrap and control-plane controllers.

## Prerequisites

To get all the `make targets` run

* `kubectl` ([source](https://github.com/kubernetes/kubectl)) in version `>= v1.27.0` is needed
* `yq` ([source](https://github.com/mikefarah/yq/)) is needed

## How it works

The `make` target `generate` transfer the upstream released `cluster-api-components.yaml` into a Giant Swarm specific `HelmChart`.
Beside the transformation into a `HelmChart` there are few other changes needed to make all the `cluster-api` components fit well into our stack.

To make all the changes transparent and reproducible, `kubectl kustomize` is used to apply (mostly) all changes.

Following notable commands/scripts are triggered in `make generate`:

1. [`hack/fetch-manifest.sh`](hack/fetch-manifest.sh)</br>
    Fetch the release manifest with the version specified in `helm/cluster-api/values.yaml`. Since we use our own fork of CAPI which does not replicate upstream GitHub releases, the YAML manifest is part of the Docker image as means to easily fetch the manifest which exactly matches the desired commit/tag.
1. `make delete-generated-helm-charts`</br>
    Cleans folder `helm/cluster-api/templates` to not get any orphaned objects in the app.
1. `kubectl kustomize config/helm -o helm/cluster-api/templates`</br>
    Apply all the defined `kustomize` changes (defined in `kustomization.yaml`)
1. [`hack/move-generated-crds.sh`](hack/move-generated-crds.sh)</br>
    Used to move all the `CRDs` into the directory `helm/cluster-api/files`. All files within this directory are later used in `Job/cluster-api-crd-install`.
1. [`hack/generate-crd-version-patches.sh`](hack/generate-crd-version-patches.sh)</br>
    Extracts the upstream `cluster-api` CRDs into `kustomize` patches under `helm/cluster-api/files`.
    With that it's easier (in PRs) to review CRD changes as our own vintage controllers also reconcile on CAPI CRs.
    The `kustomized` CRDs got applied within `Job/cluster-api-crd-install` by running `kubectl apply` with the `--kustomize` flag ([xref](https://github.com/giantswarm/cluster-api-app/blob/4f672f7a0dd79a63fc4e66bfb659f9aeefba2b02/helm/cluster-api/templates/crd-install/crd-job.yaml#L48)).
1. [`hack/wrap-with-conditional.sh`](hack/wrap-with-conditional.sh) wraps
    * all the occurrence of the `cluster.x-k8s.io/watch-filter` label selector into a `helm` condition, e.g.:

        ```yaml
        {{ if .Values.watchfilter }}
        objectSelector:
            matchLabels:
                cluster.x-k8s.io/watch-filter: '{{ .Values.watchFilter }}'
        {{ end }}
        ```

    * all files where `*_ciliumnetworkpolicy_*.yaml` matches with the global `ciliumNetworkPolicy.enabled` condition:

        ```yaml
        {{- if .Values.ciliumNetworkPolicy.enabled }}
            [...]
        {{ end }}
        ```

## Upgrading CAPI

See README of [cluster-api fork](https://github.com/giantswarm/cluster-api/blob/main/README.md) for testing and releasing changes.

It is important to run `make generate` so that the patches, app manifests and CRDs are regenerated using the new version of CAPI.

There is one thing that needs manual intervention though: **when new webhooks are added upstream**, we need to manually add them to the relevant patches (`config/helm/certificate*.yaml`).
