# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Hack: Rework `remove-curly-braces-for-helm.sh`. ([#243](https://github.com/giantswarm/cluster-api-app/pull/243))
- Chart: Replace Cilium network policies by native ones. ([#244](https://github.com/giantswarm/cluster-api-app/pull/244))
- Chart: Rework affinity & tolerations. ([#245](https://github.com/giantswarm/cluster-api-app/pull/245))
- Hack: Rework `wrap-with-conditional.sh`. ([#246](https://github.com/giantswarm/cluster-api-app/pull/246))

## [1.20.1] - 2024-07-10

### Fixed

- Don't inject conversion webhooks to CRDs if they don't have originally.

## [1.20.0] - 2024-06-11

### Changed

- Upgrade CAPI to v1.6.5

## [1.19.0] - 2024-05-22

### Changed

- Replace secret caching client with kubeadmcontrolplane client to fix CAPI migration.

## [1.18.0] - 2024-05-09

### Changed

- CNPs are added back to allow the api server to access pods for webhooks.

## [1.17.0] - 2024-05-08

### Changed

- Upgrade CAPI to v1.5.7

## [1.16.0] - 2024-05-07

### Changed

- Upgrade CAPI to v1.4.9
- Change container image registry values name to use values from `config` repo.
- Add toleration for `node.cluster.x-k8s.io/uninitialized` taint.
- Remove toleration for old `node-role.kubernetes.io/master` taint.
- Add node affinity to prefer scheduling CAPI pods to control-plane nodes.

## [1.15.2] - 2024-01-22

### Changed

- Repository: Rework `hack` & `config`. ([#176](https://github.com/giantswarm/cluster-api-app/pull/176))
- Chart: Make PSS compliant. ([#182](https://github.com/giantswarm/cluster-api-app/pull/182))
- Chart: Replace Cilium network policies by native ones. ([#188](https://github.com/giantswarm/cluster-api-app/pull/188))

## [1.15.1] - 2024-01-15

### Changed

- Make: Use `kubectl` integrated `kustomize`. ([#171](https://github.com/giantswarm/cluster-api-app/pull/171))
- Switch to image hosted on gsoci.azurecr.io

## [1.15.0] - 2023-12-20

### Changed

- Configure `gsoci.azurecr.io` as the default container image registry.
- Upgrade CAPI to v1.4.7
- Support bootstrap config reference rotation (backported feature into v1.4.x)

## [1.14.1] - 2023-09-20

### Added

- Add common labels to pods so that Hubble shows the app name

## [1.14.0] - 2023-08-09

### Changed

- Upgrade CAPI to v1.4.5
- Switch to using Giant Swarm fork for built images

## [1.13.0] - 2023-07-26

### Added

- Add network policies for egress also for `capi-kubeadm-bootstrap-controller-manager`.
- Added some comments to describe the reason for all the kustomize patches + add some notes on the `README.md`.

### Changed

- Replace deprecated kustomize config `patchesStrategicMerge`
- Fail crd-install on `kubectl get` error
- `CRD` watchfilter patches are now generated with `kustomize replacement` feature (introduced in `kustomize v5.0`)
- Re-add mistakenly removed patch for invalid manifest fields `creationTimestamp: "null"`

### Fixed

- Update cilium network policies with ingress for webhooks.
- Fix cilium network policy for delete-aggregated-roles hook.

## [1.12.0] - 2023-05-17

### Added

- Add cilium network policies to allow kube-api access.
- Add network policies for egress.

## [1.11.0] - 2023-04-25

### Changed

- Update CAPI to 1.4.0.

## [1.10.0] - 2023-04-19

### Changed

- Change default registry in Helm chart from quay.io to docker.io.

## [1.9.1] - 2023-03-22

### Added

- Added `node-role.kubernetes.io/control-plane` to crd install jobs toleration

### Changed

- Remove known broken `creationTimestamp: "null"` fields that kustomize 5.0.0+ is rendering as string rather than `nil` values

## [1.9.0] - 2023-01-25

### Changed

- Update `giantswarm/kubectl` (used for installing CRDs) version to v1.24.9.
- Update CAPI to v1.3.2

## [1.8.3] - 2023-01-06

### Changed

- Add mechanism for specifying tag per deployment.

## [1.8.2] - 2022-11-22

### Changed

- Set Helm chart ownership to team hydra.

## [1.8.1] - 2022-10-18

### Changed

- Update CAPI to v1.2.4.

## [1.8.0] - 2022-10-10

### Changed

- Update CAPI to v1.2.2.

## [1.7.0] - 2022-10-06

### Added

- Add clusterctl labels to CRDs to support `clusterctl move`.

## [1.6.0] - 2022-10-04

### Changed

- `PodSecurityPolicy` are removed on newer k8s versions, so only apply it in the `crd-install` job if object is registered in the k8s API.

## [1.5.3] - 2022-09-16

### Changed

- Update CAPI to v1.1.6

## [1.5.2] - 2022-08-04

### Added

- Enable ignition feature gate.

## [1.5.1] - 2022-07-13

### Changed

- Use `kubectl` container retagged image.

## [1.5.0] - 2022-07-12

### Fixed

- Use a specific version of the kubectl image for the crd install job

## [1.4.0] - 2022-07-11

### Changed

- Update CAPI to v1.1.5

### Added

- `schema-gen` Make target for generating values schema

## [1.3.0] - 2022-07-07

### Changed

- Updated CAPI to v1.1.0

## [1.2.0] - 2022-07-07

### Added

- Configure image domain to pull from

## [1.1.0] - 2022-05-24

### Added

- Value to control setting of the watch filter

### Fixed

- Don't remove `crd-install` job when it fails to allow debugging.

## [1.0.4] - 2022-03-09

### Changed

- Use `--ignore-not-found` when trying to delete resources from the hook.

## [1.0.3] - 2022-03-09

### Changed

- Installing CRDs via crd-install job.
- Add helm hooks to delete aggregated cluster roles before installing and upgrading the chart.

## [1.0.2] - 2022-02-09

### Added

- Remove Helm manifests before generating them.

### Changed

- Use `config` master branch.
- Upgrade to `v1.0.4`.

## [1.0.1] - 2022-02-02

### Added

- Add component label to Deployments.
- Add `make verify` to make sure manifests are up to date.

## [1.0.0] - 2022-01-27

### Changed

- Helm manifests are generated from upstream assets attached to a release.

## [0.4.1] - 2021-09-29

[Unreleased]: https://github.com/giantswarm/cluster-api-app/compare/v1.20.1...HEAD
[1.20.1]: https://github.com/giantswarm/cluster-api-app/compare/v1.20.0...v1.20.1
[1.20.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.19.0...v1.20.0
[1.19.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.18.0...v1.19.0
[1.18.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.17.0...v1.18.0
[1.17.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.16.0...v1.17.0
[1.16.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.15.2...v1.16.0
[1.15.2]: https://github.com/giantswarm/cluster-api-app/compare/v1.15.1...v1.15.2
[1.15.1]: https://github.com/giantswarm/cluster-api-app/compare/v1.15.0...v1.15.1
[1.15.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.14.1...v1.15.0
[1.14.1]: https://github.com/giantswarm/cluster-api-app/compare/v1.14.0...v1.14.1
[1.14.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.13.0...v1.14.0
[1.13.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.12.0...v1.13.0
[1.12.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.11.0...v1.12.0
[1.11.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.10.0...v1.11.0
[1.10.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.9.1...v1.10.0
[1.9.1]: https://github.com/giantswarm/cluster-api-app/compare/v1.9.0...v1.9.1
[1.9.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.8.3...v1.9.0
[1.8.3]: https://github.com/giantswarm/cluster-api-app/compare/v1.8.2...v1.8.3
[1.8.2]: https://github.com/giantswarm/cluster-api-app/compare/v1.8.1...v1.8.2
[1.8.1]: https://github.com/giantswarm/cluster-api-app/compare/v1.8.0...v1.8.1
[1.8.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.7.0...v1.8.0
[1.7.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.6.0...v1.7.0
[1.6.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.5.3...v1.6.0
[1.5.3]: https://github.com/giantswarm/cluster-api-app/compare/v1.5.2...v1.5.3
[1.5.2]: https://github.com/giantswarm/cluster-api-app/compare/v1.5.1...v1.5.2
[1.5.1]: https://github.com/giantswarm/cluster-api-app/compare/v1.5.0...v1.5.1
[1.5.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.4.0...v1.5.0
[1.4.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/giantswarm/cluster-api-app/compare/v1.0.4...v1.1.0
[1.0.4]: https://github.com/giantswarm/cluster-api-app/compare/v1.0.3...v1.0.4
[1.0.3]: https://github.com/giantswarm/cluster-api-app/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/giantswarm/cluster-api-app/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/giantswarm/cluster-api-app/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/giantswarm/cluster-api-app/compare/v0.5.3-gs1...v1.0.0
[0.4.1]: https://github.com/giantswarm/cluster-api-app/releases/tag/v0.4.1
