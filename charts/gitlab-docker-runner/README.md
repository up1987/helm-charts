## GitLab Runner with Docker excutor

GitLab Runner is an application that works with GitLab CI/CD to run jobs in a pipeline. GitLab Runner can use Docker to run jobs on user provided images.
The docker executor allows a clean build environment, with easy dependency management.

### Usage

```
helm repo add up1987 https://charts.up1987.com
helm install my-runner \
   --set gitlabUrl=<YourGitlabURL> \
   --set runnerRegistrationToken=<YourToken> \
   up1987/gitlab-docker-runner
```