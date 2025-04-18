export CUDA_DEVICE_ORDER=PCI_BUS_ID
export CUDA_HOME="${HOME}/.cuda"
export PATH="${CUDA_HOME}/bin:${PATH}"
export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${CUDA_HOME}/extras/CUPTI/lib64:${LD_LIBRARY_PATH}"
export CUDA_VISIBLE_DEVICES="0"
complete -W "$(ls -d /usr/local/cuda-* 2> /dev/null | sed 's/\/usr\/local\/cuda-//g')" chcuda
