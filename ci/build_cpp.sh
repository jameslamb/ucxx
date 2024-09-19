#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES.
# SPDX-License-Identifier: BSD-3-Clause

set -euo pipefail

rapids-configure-conda-channels

source rapids-configure-sccache

source rapids-date-string

export CMAKE_GENERATOR=Ninja

cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"/../
source ./ci/use_conda_packages_from_prs.sh

rapids-print-env

rapids-logger "Begin C++ and Python builds"

rapids-conda-retry mambabuild conda/recipes/ucxx

rapids-upload-conda-to-s3 cpp
