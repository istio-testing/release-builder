#!/usr/bin/env bash

# Copyright Istio Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

WD=$(dirname "$0")
WD=$(cd "$WD"; pwd)
ROOT=$(dirname "$WD")

set -eux

NEXT_VERSION=1.4.0
DATE=$(date '+%Y%m%d-%H-%M')
VERSION="${NEXT_VERSION}-alpha.${DATE}"

WORK_DIR="${ARTIFACTS:-$(mktemp -d)}"

MANIFEST=$(cat <<EOF
version: ${VERSION}
docker: docker.io/istio
directory: ${WORK_DIR}
dependencies:
  - org: istio
    repo: istio
    branch: master
  - org: istio
    repo: cni
    branch: master
outputs: [archive]
EOF
)

echo "${MANIFEST}"

go run "${ROOT}/main.go" build --manifest <(echo "${MANIFEST}")