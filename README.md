[![CircleCI](https://circleci.com/gh/giantswarm/cluster-api-app.svg?style=shield)](https://circleci.com/gh/giantswarm/cluster-api-app)

# cluster-api chart

This is a meta App that provides deployment packaging for Cluster API core, bootstrap and control-plane controllers.

## Prerequisites

To get all the `make` targets run

* `kubectl` ([source](https://github.com/kubernetes/kubectl)) in version `>= v1.27.0` is required
* `yq` ([source](https://github.com/mikefarah/yq)) is required

## How it works

The `make` target `generate` transfers the upstream released `cluster-api-components.yaml` into a Giant Swarm specific Helm chart. Beside the transformation into a Helm chart there are some other changes required to make all the `cluster-api` components fit well into our stack.

To make all the changes transparent and reproducible, `kubectl kustomize` is used to apply patches.

Following notable commands/scripts are triggered in `make generate`:

1. [`hack/fetch-manifest.sh`](hack/fetch-manifest.sh)\
    Fetches the release manifest with the version specified in `helm/cluster-api/values.yaml`. Since we use our own fork of CAPI that does not replicate upstream GitHub releases, the YAML manifest is part of the Docker image to easily retrieve the manifest that corresponds exactly to the desired commit/tag.
1. `make delete-generated-helm-charts`\
    Cleans the `helm/cluster-api/templates` folder to omit any orphaned objects in the app.
1. `kubectl kustomize config/helm -o helm/cluster-api/templates`\
    Applies all the defined `kustomize` changes defined in `kustomization.yaml`.
1. [`hack/move-generated-crds.sh`](hack/move-generated-crds.sh)\
    Moves all the CRDs into the `helm/cluster-api/files` directory. All files within this directory are later used in `job/cluster-api-crd-install`.
1. [`hack/generate-crd-version-patches.sh`](hack/generate-crd-version-patches.sh)\
    Extracts the upstream `cluster-api` CRDs into `kustomize` patches in `helm/cluster-api/files`.
    With that it's easier to review CRD changes in PRs as our own Vintage controllers also reconcile CAPI CRs.
    The `kustomize`d CRDs get applied within `job/cluster-api-crd-install` by running `kubectl apply` with the `--kustomize` flag ([code](https://github.com/giantswarm/cluster-api-app/blob/main/helm/cluster-api/templates/crd-install/crd-job.yaml#L48)).
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
