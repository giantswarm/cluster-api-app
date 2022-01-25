.PHONY: generate
generate:
	./hack/generate-kustomize-patches.sh
	$(MAKE) delete-generated-manifests
	kustomize build config/helm -o helm/cluster-api/templates
	./hack/move-generated-manifests.sh
	./hack/extract-crd-version-patches.sh

delete-generated-manifests:
	@rm -rf helm/cluster-api/templates/core/*
	@rm -rf helm/cluster-api/templates/bootstrap/*
	@rm -rf helm/cluster-api/templates/controlplane/*
	@rm -rf helm/cluster-api/templates/*.yaml

CRD_BUILD_DIR := out

$(CRD_BUILD_DIR):
	mkdir -p $(CRD_BUILD_DIR)/

.PHONY: release-manifests
release-manifests: $(CRD_BUILD_DIR) ## Builds the manifests to publish with a release
	# Build core-components.
	kustomize build config/helm/crds > $(CRD_BUILD_DIR)/crds.yaml
