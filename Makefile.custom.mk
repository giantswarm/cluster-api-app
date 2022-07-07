# Generate kustomize patches and all helm charts
.PHONY: generate
generate:
	./hack/generate-kustomize-patches.sh
	$(MAKE) delete-generated-helm-charts
	kustomize build config/helm -o helm/cluster-api/templates
	./hack/move-generated-crds.sh
	./hack/generate-crd-version-patches.sh
	./hack/wrap-objectselector-in-conditional.sh

delete-generated-helm-charts:
	@rm -rf helm/cluster-api/templates/*.yaml

CRD_BUILD_DIR := out

$(CRD_BUILD_DIR):
	mkdir -p $(CRD_BUILD_DIR)/

.PHONY: release-manifests
release-manifests: $(CRD_BUILD_DIR) ## Builds the manifests to publish with a release
	# Build core-components.
	kustomize build config/helm/files > $(CRD_BUILD_DIR)/crds.yaml

.PHONY: verify
verify: generate
	@if !(git diff --quiet HEAD); then \
		git diff; \
		echo "generated files are out of date, run make generate"; exit 1; \
	fi

ensure-schema-gen:
	@helm schema-gen --help &>/dev/null || helm plugin install https://github.com/mihaisee/helm-schema-gen.git

.PHONY: schema-gen
schema-gen: ensure-schema-gen ## Generates the values schema file
	@cd helm/cluster-api && helm schema-gen values.yaml > values.schema.json
