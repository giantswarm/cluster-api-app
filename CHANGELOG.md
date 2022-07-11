# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[Unreleased]: https://github.com/giantswarm/cluster-api-app/compare/v1.4.0...HEAD
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
