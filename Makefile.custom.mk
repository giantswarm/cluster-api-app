.PHONY: generate
generate:
	$(MAKE) delete-generated-manifests
	kustomize build config/helm -o helm/cluster-api/templates
	./hack/move-generated-manifests.sh

delete-generated-manifests:
	@rm -rf helm/cluster-api/templates/*
