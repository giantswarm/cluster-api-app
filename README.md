[![CircleCI](https://circleci.com/gh/giantswarm/cluster-api-app.svg?style=shield)](https://circleci.com/gh/giantswarm/cluster-api-app)

# cluster-api chart

This is a meta app that provides deployment packaging for Cluster API core, bootstrap and control-plane controllers.

## Prerequisites

To get all the `make` targets running

* `kubectl` ([source](https://github.com/kubernetes/kubectl)) in version `>= v1.27.0` is required
* `yq` ([source](https://github.com/mikefarah/yq)) is required

## How it works

The `make generate` target transfers the upstream released `cluster-api-components.yaml` into a Giant Swarm specific Helm chart. Besides there are some other changes required to make all the Cluster API components fit into our stack.

To make all the changes transparent and reproducible, `kubectl kustomize` is used to apply patches.

The following notable scripts & commands are triggered in `make generate`:

1. [`bin/fetch-manifest.sh`](bin/fetch-manifest.sh): Fetches the release manifest with the version specified in `helm/cluster-api/values.yaml`.
1. `kubectl kustomize manifests --output helm/cluster-api/templates`: Applies all the changes defined in `kustomization.yaml`.
1. [`bin/move-generated-crds.sh`](bin/move-generated-crds.sh): Moves all the CRDs into the `helm/cluster-api/files` directory. All files within this directory are later used in `job/cluster-api-crd-install`.
1. [`bin/generate-crd-version-patches.sh`](bin/generate-crd-version-patches.sh): Extracts the upstream Cluster API CRDs into `kustomize` patches in `helm/cluster-api/files`.
1. [`bin/wrap-with-conditional.sh`](bin/wrap-with-conditional.sh)
    * Wraps all occurrences of the `cluster.x-k8s.io/watch-filter` object selector into a condition:
        ```yaml
        {{ if .Values.watchfilter }}
        objectSelector:
            matchLabels:
                cluster.x-k8s.io/watch-filter: '{{ .Values.watchFilter }}'
        {{ end }}
        ```
    * Wraps all the `*_ciliumnetworkpolicy_*.yaml` manifests into the global `ciliumNetworkPolicy.enabled` condition:
        ```yaml
        {{- if .Values.ciliumNetworkPolicy.enabled }}
        [...]
        {{ end }}
        ```

## Upgrading CAPI

See the [`README.md`](https://github.com/giantswarm/cluster-api/blob/main/README.md) of our Cluster API fork for testing and releasing changes.

It is important to run `make generate` so that the templates, CRDs and patches are regenerated using the new version of CAPI.

**NOTE:** When new webhooks are added upstream, we need to manually add them to the relevant patches (`manifests/certificate*.yaml`).
