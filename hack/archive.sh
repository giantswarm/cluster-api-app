#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

cd helm/cluster-api/files

rm *.tar.gz || echo

tar -cvzf core.tar.gz core/
tar -cvzf bootstrap.tar.gz bootstrap/
tar -cvzf controlplane.tar.gz controlplane/
