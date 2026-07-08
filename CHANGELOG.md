# Changelog

All notable changes to this project are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-07-08

### Added

- GCP landing zone: resource folder hierarchy, organization policy
  constraints, a Shared VPC host project with subnets, centralized logging
  sinks, and IAM baseline bindings.
- Modular Terraform layout with reusable submodules under `modules/`.
- Environment-specific configuration for `dev` and `prod`.
- CI pipeline (fmt, validate, tflint), pre-commit hooks, and open-source
  project files (LICENSE, CONTRIBUTING, SECURITY, CODE_OF_CONDUCT).
