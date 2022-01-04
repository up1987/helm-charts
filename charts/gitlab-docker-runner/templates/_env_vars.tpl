{{- define "gitlab-docker-runner.runner-env-vars" -}}
- name: CI_SERVER_URL
  value: {{ default "" .Values.gitlabUrl | quote }}
- name: RUNNER_EXECUTOR
  value: {{ default "docker" .Values.runners.executor | quote }}
- name: REGISTER_LOCKED
  {{ if or (not (hasKey .Values.runners "locked")) .Values.runners.locked -}}
  value: "true"
  {{- else -}}
  value: "false"
  {{- end }}
- name: RUNNER_TAG_LIST
  value: {{ default "" .Values.runners.tags | quote }}
- name: DOCKER_HOST
  value: "tcp://127.0.0.1:2376"
- name: DOCKER_TLS_CERTDIR
  value: "/certs"
- name: DOCKER_CERT_PATH
  value: "/certs/client"
- name: DOCKER_TLS_VERIFY
  value: "1"
{{- end -}}