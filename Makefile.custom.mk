.PHONY: generate
generate:
	$(MAKE) delete-generated-manifests
	kustomize build config/helm -o helm/cluster-api/templates
	./hack/move-generated-manifests.sh
	./hack/extract-crd-version-patches.sh

delete-generated-manifests:
	@rm -rf helm/cluster-api/templates/*
