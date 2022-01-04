{{- define "gitlab-docker-runner.containers" -}}
- name: {{ .Chart.Name }}
  image: {{ .Values.image.repository }}
  imagePullPolicy: {{ default "" .Values.image.imagePullPolicy | quote }}
  securityContext: {{- toYaml .Values.securityContext | nindent 4 }}
  command: ["/usr/bin/dumb-init", "--", "/bin/bash", "/configmaps/entrypoint"]
  env: {{- include "gitlab-docker-runner.runner-env-vars" . | nindent 4 }}
  livenessProbe:
    exec:
      command: ["/bin/bash", "/configmaps/check-live"]
    initialDelaySeconds: 60
    timeoutSeconds: {{ default 1 .Values.probeTimeoutSeconds }}
    periodSeconds: 10
    successThreshold: 1
    failureThreshold: 3
  readinessProbe:
    exec:
      command: ["/usr/bin/pgrep","gitlab.*runner"]
    initialDelaySeconds: 10
    timeoutSeconds: {{ default 1 .Values.probeTimeoutSeconds }}
    periodSeconds: 10
    successThreshold: 1
    failureThreshold: 3
  ports:
  - name: metrics
    containerPort: {{ .Values.metrics.port }}
  volumeMounts:
  - name: runner-data
    subPath: etc
    mountPath: /home/gitlab-runner/.gitlab-runner
  - name: configmaps
    mountPath: /configmaps
  {{- if .Values.certsSecretName }}
  - name: custom-certs
    readOnly: true
    mountPath: /home/gitlab-runner/.gitlab-runner/certs/
  {{- end }}
  - name: runner-data
    subPath: builds
    mountPath: /builds
  - name: runner-data
    subPath: cache
    mountPath: /cache
  - name: runner-data
    subPath: docker-certs
    mountPath: /certs
  resources:
    {{- toYaml .Values.resources | nindent 4 }}
- name: docker
  image: {{ .Values.docker.repository }}
  imagePullPolicy: {{ default "" .Values.docker.imagePullPolicy | quote }}
  securityContext:
    privileged: true
  env: {{- include "gitlab-docker-runner.runner-env-vars" . | nindent 4 }}
  volumeMounts:
  - name: runner-data
    subPath: builds
    mountPath: /builds
  - name: runner-data
    subPath: cache
    mountPath: /cache
  - name: runner-data
    subPath: docker
    mountPath: /var/lib/docker
  - name: runner-data
    subPath: docker-certs
    mountPath: /certs
{{- end -}}