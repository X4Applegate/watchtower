> **🍴 Fork Notice:** This is an actively maintained fork of [containrrr/watchtower](https://github.com/containrrr/watchtower) by [@X4Applegate](https://github.com/X4Applegate).
> > The upstream project is no longer maintained. This fork applies bug fixes and dependency updates. See [CHANGELOG.md](./CHANGELOG.md) for details.
> >
> > <div align="center">

<img src="./logo.png" width="450" />

# Watchtower

A process for automating Docker container base image updates.
<br/><br/>

[![Circle CI](https://circleci.com/gh/containrrr/watchtower.svg?style=shield)](https://circleci.com/gh/containrrr/watchtower)
[![Codecov](https://codecov.io/gh/containrrr/watchtower/branch/main/graph/badge.svg)](https://codecov.io/gh/containrrr/watchtower)
[![GoDoc](https://godoc.org/github.com/containrrr/watchtower?status.svg)](https://godoc.org/github.com/containrrr/watchtower)
[![Go_Report_Card](https://goreportcard.com/badge/github.com/containrrr/watchtower)](https://goreportcard.com/report/github.com/containrrr/watchtower)
[![latest_version](https://img.shields.io/github/tag/containrrr/watchtower.svg)](https://github.com/containrrr/watchtower/releases)
[![Apache-2.0 License](https://img.shields.io/github/license/containrrr/watchtower.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/1c48cfb7646d4009aa8c6f71287670b8)](https://www.codacy.com/gh/containrrr/watchtower/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=containrrr/watchtower&amp;utm_campaign=Badge_Grade)
[![All Contributors](https://img.shields.io/github/all-contributors/containrrr/watchtower)](https://github.com/containrrr/watchtower#contributors)
[![Pulls from DockerHub](https://img.shields.io/docker/pulls/containrrr/watchtower.svg)](https://hub.docker.com/r/containrrr/watchtower)

</div>

## Quick Start

With watchtower you can update the running version of your containerized app simply by pushing a new image to the Docker Hub or your own image registry. Watchtower will pull down your new image, gracefully shut down your existing container and restart it with the same options that were used when it was deployed initially.

Run the watchtower container with the following command:

```
$ docker run --detach \
  --name watchtower \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower
```

Watchtower is intended to be used in homelabs, media centers, local dev environments, and similar. We do not recommend using Watchtower in a commercial or production environment. If that is you, you should be looking into using [Kubernetes](https://kubernetes.io/). If that feels like too big a step for you, please look into solutions like [MicroK8s](https://microk8s.io/) and [k3s](https://k3s.io/) that take away a lot of the toil of running a Kubernetes cluster.

## Documentation

The full documentation is available at https://containrrr.dev/watchtower.
