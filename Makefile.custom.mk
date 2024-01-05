.PHONY: generate verify

generate:
	rm helm/cluster-api/templates/*.yaml
	hack/fetch-manifest.sh
	kubectl kustomize config/helm --output helm/cluster-api/templates
	rm helm/cluster-api/templates/v1_configmap_watchfilter-patch.yaml
	hack/move-generated-crds.sh
	hack/generate-crd-version-patches.sh
	hack/wrap-with-conditional.sh

verify: generate
	@if ! git diff --exit-code ; then \
		echo "Generated templates are out of date. Run make generate." ; \
		exit 1 ; \
	fi
