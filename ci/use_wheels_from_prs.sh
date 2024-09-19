#!/bin/bash

RAPIDS_PY_CUDA_SUFFIX="$(rapids-wheel-ctk-name-gen ${RAPIDS_CUDA_VERSION})"

LIBRMM_CHANNEL=$(
  RAPIDS_PY_WHEEL_NAME=rmm_${RAPIDS_PY_CUDA_SUFFIX} rapids-get-pr-wheel-artifact rmm 1678 cpp
)
RMM_CHANNEL=$(
  RAPIDS_PY_WHEEL_NAME=rmm_${RAPIDS_PY_CUDA_SUFFIX} rapids-get-pr-wheel-artifact rmm 1678 python
)

# UCXX_CHANNEL=$(
#   RAPIDS_PY_WHEEL_NAME=ucxx_${RAPIDS_PY_CUDA_SUFFIX} rapids-get-pr-wheel-artifact ucxx 278 python
# )
# LIBUCXX_CHANNEL=$(
#   RAPIDS_PY_WHEEL_NAME=libucxx_${RAPIDS_PY_CUDA_SUFFIX} rapids-get-pr-wheel-artifact ucxx 278 cpp
# )
# DISTRIBUTED_UCXX_CHANNEL=$(
#   RAPIDS_PY_WHEEL_NAME=distributed_ucxx_${RAPIDS_PY_CUDA_SUFFIX} rapids-get-pr-wheel-artifact ucxx 278 python
# )

CUDF_CHANNEL=$(
  RAPIDS_PY_WHEEL_NAME=cudf_${RAPIDS_PY_CUDA_SUFFIX} rapids-get-pr-wheel-artifact cudf 16806 python
)
LIBCUDF_CHANNEL=$(
  RAPIDS_PY_WHEEL_NAME=libcudf_${RAPIDS_PY_CUDA_SUFFIX} rapids-get-pr-wheel-artifact cudf 16806 cpp
)
PYLIBCUDF_CHANNEL=$(
  RAPIDS_PY_WHEEL_NAME=pylibcudf_${RAPIDS_PY_CUDA_SUFFIX} rapids-get-pr-wheel-artifact cudf 16806 python
)
DASK_CUDF_CHANNEL=$(
  RAPIDS_PY_WHEEL_NAME=dask_cudf_${RAPIDS_PY_CUDA_SUFFIX} \
  RAPIDS_PY_WHEEL_PURE=1 \
    rapids-get-pr-wheel-artifact cudf 16806 python
)

# RAFT_DASK_CHANNEL=$(
#   RAPIDS_PY_WHEEL_NAME=raft_dask_${RAPIDS_PY_CUDA_SUFFIX} rapids-get-pr-wheel-artifact raft 2433 python
# )
# PYLIBRAFT_CHANNEL=$(
#   RAPIDS_PY_WHEEL_NAME=pylibraft_${RAPIDS_PY_CUDA_SUFFIX} rapids-get-pr-wheel-artifact raft 2433 python
# )

cat > /tmp/constraints.txt <<EOF
librmm-${RAPIDS_PY_CUDA_SUFFIX} @ file://$(echo ${LIBRMM_CHANNEL}/librmm_*.whl)
rmm-${RAPIDS_PY_CUDA_SUFFIX} @ file://$(echo ${RMM_CHANNEL}/rmm_*.whl)
cudf-${RAPIDS_PY_CUDA_SUFFIX} @ file://$(echo ${CUDF_CHANNEL}/cudf_*.whl)
libcudf-${RAPIDS_PY_CUDA_SUFFIX} @ file://$(echo ${LIBCUDF_CHANNEL}/libcudf_*.whl)
pylibcudf-${RAPIDS_PY_CUDA_SUFFIX} @ file://$(echo ${PYLIBCUDF_CHANNEL}/pylibcudf_*.whl)
dask-cudf-${RAPIDS_PY_CUDA_SUFFIX} @ file://$(echo ${DASK_CUDF_CHANNEL}/dask_cudf_*.whl)
EOF
# ucxx-${RAPIDS_PY_CUDA_SUFFIX} @ file://${UCXX_CHANNEL}
# libucxx-${RAPIDS_PY_CUDA_SUFFIX} @ file://${LIBUCXX_CHANNEL}
# distributed-ucxx-${RAPIDS_PY_CUDA_SUFFIX} @ file://${DISTRIBUTED_UCXX_CHANNEL}
# raft-dask-${RAPIDS_PY_CUDA_SUFFIX} @ file://${RAFT_DASK_CHANNEL}
# pylibraft-${RAPIDS_PY_CUDA_SUFFIX} @ file://${PYLIBRAFT_CHANNEL}
export PIP_CONSTRAINT=/tmp/constraints.txt
