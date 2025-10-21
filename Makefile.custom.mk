OS ?= $(shell go env GOOS 2>/dev/null || echo linux)
ARCH ?= $(shell go env GOARCH 2>/dev/null || echo amd64)
YQ_BIN_VERSION := 4.48.1
YQ_BIN := ./bin/yq

$(YQ_BIN): ## Download yq locally if necessary.
	mkdir -p $(dir $@)
	curl -sfL https://github.com/mikefarah/yq/releases/download/v$(YQ_BIN_VERSION)/yq_$(OS)_$(ARCH) -o $@
	chmod +x $@

.PHONY: clean
clean:
	rm -f $(YQ_BIN)

.PHONY: generate
generate: $(YQ_BIN)
	# Fetch Cluster API components.
	hack/fetch-manifest.sh

	# Kustomize templates.
	rm -f helm/cluster-api/templates/*.yaml
	kubectl kustomize config/helm --output helm/cluster-api/templates

	# Move CRDs.
	hack/move-crds.sh

	# Generate patches.
	hack/generate-patches.sh

	# Remove braces.
	hack/remove-braces.sh
