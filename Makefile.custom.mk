.PHONY: generate verify

generate:
	# Fetch Cluster API components.
	hack/fetch-manifest.sh

	# Kustomize templates.
	rm -f helm/cluster-api/templates/*.yaml
	kubectl kustomize config/helm --output helm/cluster-api/templates
	rm -f helm/cluster-api/templates/v1_configmap_watch-filter.yaml

	# Move CRDs.
	hack/move-crds.sh

	hack/generate-crd-version-patches.sh
	hack/wrap-with-conditional.sh

verify: generate
	@if ! git diff --exit-code ; then \
		echo "Generated templates are out of date. Run make generate." ; \
		exit 1 ; \
	fi
