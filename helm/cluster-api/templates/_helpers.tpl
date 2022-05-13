{{/* vim: set filetype=mustache: */}}
{{/* Expand the name of the chart. This is suffixed with -alertmanager, which means subtract 13 from longest 63 available */}}
{{- define "cluster-api.name" -}}
{{- .Chart.Name | trunc 50 | trimSuffix "-" -}}
{{- end }}

{{- define "cluster-api.crdInstall" -}}
{{- printf "%s-%s" ( include "cluster-api.name" . ) "crd-install" | replace "+" "_" | trimSuffix "-" -}}
{{- end -}}

{{- define "cluster-api.CRDInstallAnnotations" -}}
"helm.sh/hook": "pre-install,pre-upgrade"
"helm.sh/hook-delete-policy": "before-hook-creation,hook-succeeded"
{{- end -}}

{{- define "cluster-api.selectorLabels" -}}
app.kubernetes.io/name: "{{ template "cluster-api.name" . }}"
app.kubernetes.io/instance: "{{ template "cluster-api.name" . }}"
{{- end -}}

{{/* Create a label which can be used to select any orphaned crd-install hook resources */}}
{{- define "cluster-api.CRDInstallSelector" -}}
{{- printf "%s" "crd-install-hook" -}}
{{- end -}}
