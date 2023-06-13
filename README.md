[![CircleCI](https://circleci.com/gh/giantswarm/cluster-api-app.svg?style=shield)](https://circleci.com/gh/giantswarm/cluster-api-app)

# cluster-api chart

This is a meta App that provides deployment packaging for Cluster API core, bootstrap and control-plane controllers.

## Upgrading CAPI

See README of [cluster-api fork](https://github.com/giantswarm/cluster-api/blob/main/README.md) for testing and releasing changes.

It is important to run `make generate` so that the patches, app manifests and CRDs are regenerated using the new version of CAPI.

There is one thing that needs manual intervention though: **when new webhooks are added upstream**, we need to manually add them to the relevant patches (`config/helm/certificate*.yaml`).
