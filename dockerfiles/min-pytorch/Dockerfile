FROM nvidia/cuda:11.7.1-base-ubuntu20.04
# NVIDIA RTX A6000

LABEL maintainer "Kanta Yamaoka"

# Language setting
ENV LANG C.UTF-8

# [L1] Layer for python3.8, pip and its configurations.
RUN apt update \
    && apt -y upgrade \
    && apt install -y python3 \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1 \
    && apt install -y python3-pip

# [L2] Layer for ML backend, e.g., pytorch.
# - For A6000, do NOT include pytorch, and torchvision to the req_ml_backent.txt.
# - As of now, Sept. 2022, sm_86 support is available in the preview version.
#   - https://discuss.pytorch.org/t/need-help-trouble-with-cuda-capability-sm-86/120235/39
#   - https://qiita.com/tatefuku_hiroshi/items/61cdf3ba595bd3d7a24d

COPY req_ml_backend.txt ./
RUN pip install -r req_ml_backend.txt \
    && pip install --pre torch torchvision --extra-index-url https://download.pytorch.org/whl/nightly/cu117

# [L3] Layer for visualization and other misc tools, e.g., jupyterlab.
# - These packages could be changed often, so this layer is separated to save build time.
COPY req_ml_tools.txt ./
RUN pip install -r req_ml_tools.txt
