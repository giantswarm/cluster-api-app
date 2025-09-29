.PHONY: generate
generate:
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
