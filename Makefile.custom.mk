.PHONY: generate
generate:
	kustomize build config/helm -o helm/cluster-api-provider-azure/templates
	rm -rf helm/cluster-api/templates/apiextensions* helm/cluster-api/templates/cert-manager.io_v1_issuer*