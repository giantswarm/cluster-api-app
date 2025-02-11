{{/*
Create a default fully qualified app name.
*/}}
{{- define "cluster-api.delete-aggregated-roles.fullname" -}}
{{- printf "%s-%s" (include "cluster-api.fullname" .) "delete-aggregated-roles" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cluster-api.delete-aggregated-roles.labels" -}}
{{- include "cluster-api.labels" . }}
app.kubernetes.io/component: delete-aggregated-roles
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cluster-api.delete-aggregated-roles.selectorLabels" -}}
{{- include "cluster-api.selectorLabels" . }}
app.kubernetes.io/component: delete-aggregated-roles
{{- end }}

{{/*
Common annotations
*/}}
{{- define "cluster-api.delete-aggregated-roles.annotations" -}}
helm.sh/hook: pre-install,pre-upgrade
helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
{{- end }}
