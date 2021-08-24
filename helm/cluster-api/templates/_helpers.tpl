{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "labels.common" -}}
app.giantswarm.io/branch: {{ .Values.project.branch | quote }}
app.giantswarm.io/commit: {{ .Values.project.commit | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
helm.sh/chart: {{ include "chart" . | quote }}
{{- end -}}

{{- define "labels.common.bootstrap" -}}
{{ include "labels.selector.bootstrap" . }}
{{ include "labels.common" . }}
{{- end -}}

{{- define "labels.common.controlplane" -}}
{{ include "labels.selector.controlplane" . }}
{{ include "labels.common" . }}
{{- end -}}

{{- define "labels.common.core" -}}
{{ include "labels.selector.core" . }}
{{ include "labels.common" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "labels.selector" -}}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end -}}

{{- define "labels.selector.bootstrap" -}}
app.kubernetes.io/name: {{ include "resource.bootstrap.name" . | quote }}
{{ include "labels.selector" . }}
{{- end -}}

{{- define "labels.selector.controlplane" -}}
app.kubernetes.io/name: {{ include "resource.controlplane.name" . | quote }}
{{ include "labels.selector" . }}
{{- end -}}

{{- define "labels.selector.core" -}}
app.kubernetes.io/name: {{ include "resource.core.name" . | quote }}
{{ include "labels.selector" . }}
{{- end -}}
