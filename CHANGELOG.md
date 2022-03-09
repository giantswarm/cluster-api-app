# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.3] - 2022-03-09

### Changed

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

[Unreleased]: https://github.com/giantswarm/cluster-api-app/compare/v1.0.3...HEAD
[1.0.3]: https://github.com/giantswarm/giantswarm/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/giantswarm/giantswarm/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/giantswarm/giantswarm/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/giantswarm/giantswarm/compare/v0.5.3-gs1...v1.0.0
[0.4.1]: https://github.com/giantswarm/cluster-api-app/releases/tag/v0.4.1
