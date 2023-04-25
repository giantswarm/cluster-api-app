# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[Unreleased]: https://github.com/giantswarm/cluster-api-app/compare/v1.11.0...HEAD
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
