{{/*
Create a default fully qualified app name.
*/}}
{{- define "cluster-api.crd-install.fullname" -}}
{{- printf "%s-%s" (include "cluster-api.fullname" .) "crd-install" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cluster-api.crd-install.labels" -}}
{{- include "cluster-api.labels" . }}
app.kubernetes.io/component: crd-install
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cluster-api.crd-install.selectorLabels" -}}
{{- include "cluster-api.selectorLabels" . }}
app.kubernetes.io/component: crd-install
{{- end }}

{{/*
Common annotations
*/}}
{{- define "cluster-api.crd-install.annotations" -}}
helm.sh/hook: pre-install,pre-upgrade
helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
{{- end }}
