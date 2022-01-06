---
title: "Gitlab Docker Runner"
---

## Introduction

GitLab Runner is an application that works with GitLab CI/CD to run jobs in a pipeline. GitLab Runner can use Docker to run jobs on user provided images. The docker executor allows a clean build environment, with easy dependency management.

## Installing the Chart

```
helm repo add up1987 https://charts.up1987.com
helm install my-runner \
   --set gitlabUrl=<YourGitlabURL> \
   --set runnerRegistrationToken=<YourToken> \
   up1987/gitlab-docker-runner
```

These commands deploy Gitlab Docker Runner on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

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
| `gitlabUrl`              | The GitLab Server URL (with protocol) that want to register the runner against.         | ``              |
| `runnerRegistrationToken` | The Registration Token for adding new Runners to the GitLab Server.                    | ``              |
| `runner.tags`            | Specify the tags associated with the runner. Comma-separated list of tags.              | `[ docker ]`    |
| `runner.concurrent`      | Configure the maximum number of concurrent jobs.                                        | `10`            |
| `persistence.enabled`    | Enable data persistence using PVC, If false, use emptyDir.                              | `true`          |