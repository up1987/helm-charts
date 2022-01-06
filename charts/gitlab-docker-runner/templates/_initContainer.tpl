{{- define "gitlab-docker-runner.initContainers" -}}
- name: configure
  command: ['bash', '/configmaps/configure']
  image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
  imagePullPolicy: {{ default "" .Values.image.pullPolicy | quote }}
  securityContext: {{- toYaml .Values.securityContext | nindent 4 }}
  env: {{- include "gitlab-docker-runner.runner-env-vars" . | nindent 4 }}
  volumeMounts:
  - name: configmaps
    mountPath: /configmaps
    readOnly: true
  - name: init-runner-secrets
    mountPath: /init-secrets
    readOnly: true
  - name: runner-data
    subPath: etc
    mountPath: /home/gitlab-runner/.gitlab-runner
  {{- if .Values.certsSecretName }}
  - name: custom-certs
    readOnly: true
    mountPath: /home/gitlab-runner/.gitlab-runner/certs/
  {{- end }}
  resources: {{- toYaml .Values.resources | nindent 4 }}
{{- end -}}