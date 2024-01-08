.PHONY: generate verify

generate:
	rm helm/cluster-api/templates/*.yaml
	bin/fetch-manifest.sh
	kubectl kustomize manifests --output helm/cluster-api/templates
	rm helm/cluster-api/templates/v1_configmap_watchfilter-patch.yaml
	bin/move-generated-crds.sh
	bin/generate-crd-version-patches.sh
	bin/wrap-with-conditional.sh

verify: generate
	@if ! git diff --exit-code ; then \
		echo "Generated templates are out of date. Run make generate." ; \
		exit 1 ; \
	fi
