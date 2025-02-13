.PHONY: generate
generate:
	# Fetch Cluster API components.
	hack/fetch-manifest.sh

	# Kustomize templates.
	rm -f helm/cluster-api/templates/*.yaml
	kubectl kustomize config/helm --output helm/cluster-api/templates
	rm -f helm/cluster-api/templates/v1_configmap_watch-filter.yaml

	# Move CRDs.
	hack/move-crds.sh

	# Generate patches.
	hack/generate-patches.sh

	# Wrap object selectors in conditions.
	hack/wrap-in-conditions.sh

	# Remove braces.
	hack/remove-braces.sh
