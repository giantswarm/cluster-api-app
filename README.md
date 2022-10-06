[![CircleCI](https://circleci.com/gh/giantswarm/cluster-api-app.svg?style=shield)](https://circleci.com/gh/giantswarm/cluster-api-app)

# cluster-api chart

This is a meta App that provides deployment packaging for Cluster API core, bootstrap and control-plane controllers.

## Upgrading CAPI

If you want to upgrade the CAPI version used in this app, there is a value in the `values.yaml` file of the helm chart that controls which CAPI version to use.

Once you have changed that value, you may run `make generate` so that the app helm manifests and CRDs are regenerated using that version of CAPI.
Manifests will be generated automatically from the source manifests attached to the Github release of the selected version.

There is one thing that needs manual intervention though. **When new webhooks are added upstream** we need to add them to the following `kustomize` patches:
- webhook-certificate.yaml
- webhook-watchfilter.yaml
