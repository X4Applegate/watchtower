# Changelog

All notable changes to this fork of [containrrr/watchtower](https://github.com/containrrr/watchtower) are documented here.

This fork is maintained by [@X4Applegate](https://github.com/X4Applegate) for personal/homelab use. It is based on the upstream project which is no longer officially maintained (see [containrrr#2135](https://github.com/containrrr/watchtower/issues/2135)).

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [Unreleased] - 2026-04-04

### Fixed

- **Critical nil pointer panic in `ExecutePostUpdateCommand`** (`pkg/lifecycle/lifecycle.go`)
  - Moved `timeout := newContainer.PostUpdateTimeout()` to after the `err != nil` guard on `client.GetContainer()`.
    - Previously, if `GetContainer()` returned an error, calling a method on the zero-value container would cause a nil pointer panic.

    - **Silent error suppression in `ExecutePreChecks` and `ExecutePostChecks`** (`pkg/lifecycle/lifecycle.go`)
      - Added `log.WithError(err).Error(...)` logging when `client.ListContainers()` fails.
        - Previously, failures were silently swallowed with a bare `return`, making them invisible to operators.

        - **Log ordering in `GetPullOptions`** (`pkg/registry/registry.go`)
          - Moved `log.Debugf("Getting pull options for image: %s", imageName)` to before the `EncodedAuth()` call.
            - Previously the log fired after the call and on error paths, and had a misleading "Got image name" message.

            ### Changed

            - **Go version bumped from `1.20` to `1.22`** (`go.mod`)
              - Go 1.20 reached end-of-life. Go 1.22 brings performance improvements and stdlib updates.

              ### Dependencies Updated

              | Package | From | To | Notes |
              |---|---|---|---|
              | `golang.org/x/net` | v0.19.0 | v0.26.0 | Security: HTTP/2 patches |
              | `golang.org/x/sys` | v0.15.0 | v0.21.0 | |
              | `golang.org/x/text` | v0.14.0 | v0.16.0 | |
              | `google.golang.org/protobuf` | v1.31.0 | v1.34.2 | |
              | `github.com/golang/protobuf` | v1.5.3 | v1.5.4 | |
              | `github.com/docker/docker` | v24.0.7 | v26.1.4 | |
              | `github.com/docker/cli` | v24.0.7 | v26.1.4 | |
              | `github.com/docker/go-connections` | v0.4.0 | v0.5.0 | |
              | `github.com/docker/docker-credential-helpers` | v0.6.1 | v0.8.2 | |
              | `github.com/docker/go-units` | v0.4.0 | v0.5.0 | |
              | `github.com/distribution/reference` | v0.5.0 | v0.6.0 | |
              | `github.com/onsi/ginkgo` | v1.16.5 | v2.19.0 | Major: migrated to Ginkgo v2 |
              | `github.com/onsi/gomega` | v1.30.0 | v1.33.1 | |
              | `github.com/robfig/cron` | v1.2.0 | v3.0.1 | Major: migrated to cron/v3 |
              | `github.com/prometheus/client_golang` | v1.18.0 | v1.19.1 | |
              | `github.com/prometheus/client_model` | v0.5.0 | v0.6.1 | |
              | `github.com/prometheus/common` | v0.45.0 | v0.54.0 | |
              | `github.com/prometheus/procfs` | v0.12.0 | v0.15.1 | |
              | `github.com/spf13/cobra` | v1.8.0 | v1.8.1 | |
              | `github.com/spf13/viper` | v1.18.2 | v1.19.0 | |
              | `github.com/stretchr/testify` | v1.8.4 | v1.9.0 | |
              | `github.com/stretchr/objx` | v0.5.0 | v0.5.2 | |
              | `github.com/opencontainers/image-spec` | v1.0.2 | v1.1.0 | |
              | `github.com/moby/term` | v0.0.0-... | v0.5.0 | |
              | `github.com/morikuni/aec` | v0.0.0-... | v1.0.0 | |
              | `github.com/fatih/color` | v1.15.0 | v1.17.0 | |
              | `github.com/mattn/go-isatty` | v0.0.17 | v0.0.20 | |
              | `github.com/cespare/xxhash/v2` | v2.2.0 | v2.3.0 | |
              | `golang.org/x/exp` | v0.0.0-20230905 | v0.0.0-20240613 | |
              | `go.uber.org/atomic` | v1.9.0 | v1.11.0 | |
              | `go.uber.org/multierr` | v1.9.0 | v1.11.0 | |
              | `github.com/pelletier/go-toml/v2` | v2.1.0 | v2.2.2 | |
              | `gotest.tools/v3` | v3.0.3 | v3.5.1 | |

              > **Note:** The `go.mod` dependency updates require running `go mod tidy` locally to regenerate `go.sum` before building.

              ---

              ## Prior History

              This fork was created on 2026-04-04 from [containrrr/watchtower](https://github.com/containrrr/watchtower) at commit `ca0e86e` (upstream `main` branch, last updated December 2025).

              For the full history of the upstream project prior to this fork, see the [upstream commit log](https://github.com/containrrr/watchtower/commits/main).
