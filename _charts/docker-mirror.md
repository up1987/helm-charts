---
title: "Docker Mirror"
---

## Introduction

Docker Mirror is a pull through cache docker registry with multiple remote registry support.

## Installing the Chart

```
helm repo add up1987 https://charts.up1987.com
helm install my-release up1987/docker-mirror
```

These commands deploy Docker Mirror on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

| Name                     | Description                                                                             | Value           |
| ------------------------ | --------------------------------------------------------------------------------------- | --------------- |
| `nginx.max_cache_size`   | Limit the maximum cache size                                                            | `200g`           |
| `nginx.cache_inactive`   | Automatically delete caches which is no longer active after a period of time            | `60d`            |
| `nginx.cache_time`       | Setup the caching validate time                                                         | `1h`             |
| `nginx.cache_response`   | Which HTTP responses are cached                                                         | `[ 200, 206 ]`   |
| `repo`                   | Setup remote repositories.                                                              | see values.yaml  |
| `ingress.enabled`        | Enable ingress resource for deployment                                                  | `false`          |
| `persistence.enabled`    | Enable data persistence using PVC, If false, use emptyDir                               | `true`           |