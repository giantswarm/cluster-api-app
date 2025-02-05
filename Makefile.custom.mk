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

	hack/remove-braces.sh

.PHONY: verify
verify: generate
	@if ! git diff --exit-code ; then \
		echo "Generated templates are out of date. Run make generate." ; \
		exit 1 ; \
	fi
