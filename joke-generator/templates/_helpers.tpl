{{/*
Define standard labels for all resources
*/}}
{{- define "joke-generator.labels" -}}
app: joke-generator
chart: {{ .Chart.Name }}-{{ .Chart.Version }}
release: {{ .Release.Name }}
namespace: {{ .Values.namespace }}
{{- end }}

{{/*
Generate a full name for resources
*/}}
{{- define "joke-generator.fullname" -}}
{{ .Release.Name }}-joke-generator
{{- end }}
