{{- define "gitlab-docker-runner.volumes" -}}
- name: runner-secrets
  emptyDir:
    medium: "Memory"
- name: init-runner-secrets
  projected:
    sources:
      - secret:
          name: {{ include "gitlab-docker-runner.fullname" . }}
          items:
            - key: runner-registration-token
              path: runner-registration-token
      {{- range .Values.secrets }}
      - secret:
        {{ toYaml . | indent 8 }}
      {{- end }}
{{- if .Values.certsSecretName }}
- name: custom-certs
  secret:
    secretName: {{ .Values.certsSecretName }}
{{- end }}
- name: configmaps
  configMap:
    name: {{ include "gitlab-docker-runner.fullname" . }}
{{- if not .Values.persistence.enabled }}
- name: runner-data
  {{- if .Values.persistence.medium }}
  emptyDir:
    medium: {{ .Values.persistence.medium | quote }}
  {{- else }}
  emptyDir: {}
  {{- end }}
{{- else if .Values.persistence.existingClaim }}
- name: runner-data
  persistentVolumeClaim:
    claimName: {{ printf "%s" (tpl .Values.persistence.existingClaim .) }}
{{- end }}
{{- end -}}