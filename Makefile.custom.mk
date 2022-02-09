.PHONY: generate
generate:
	rm -rf helm/cluster-api/templates/*
	kustomize build config/helm -o helm/cluster-api/templates
	rm -rf helm/cluster-api/templates/apiextensions* helm/cluster-api/templates/cert-manager.io_v1_issuer*


.PHONY: verify
verify: generate
	@if !(git diff --quiet HEAD); then \
		git diff; \
		echo "generated files are out of date, run make generate"; exit 1; \
	fi
