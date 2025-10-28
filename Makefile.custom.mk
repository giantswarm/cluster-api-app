OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH ?= $(shell uname -m | sed 's/x86_64/amd64/; s/aarch64/arm64/')

# used by renovate
# repo: mikefarah/yq
YQ_BIN_VERSION := 4.48.1
YQ_BIN := bin/yq

$(YQ_BIN): ## Download yq locally if necessary.
	mkdir -p "$(dir $@)"
	curl --silent --show-error --fail --location https://github.com/mikefarah/yq/releases/download/v$(YQ_BIN_VERSION)/yq_$(OS)_$(ARCH) -o $@
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
