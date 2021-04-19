# Environmental Variables

In this section, some default environmental variables will be introduced. One will understand what these these variable is used for and be able to make changes to suite their needs.

# CUDA Related Variables

## CUDA_DEVICE_ORDER
    
This variable governs how the CUDA devices is ordered on the machine. By default, this variable is set to `PCI_BUS_ID`. This implies that the the GPUs is ordered by the PCIe lanes it is installed on. For example, GPU0 is installed on the first PCIe lane on the machine, GPU1 on the second, and GPU2 on the third.

## CUDA_HOME

This variable provides the path to the CUDA toolchain for all CUDA programs. By default, its value is set to `${HOME}/.cuda`, which is a per user symbolic link to the actual directories that contains the binaries and the dependencies of CUDA. ***Please do not change the value of this variable manually***. If a different CUDA version is desired, use the `chcuda` command as mentioned [here](./command.md#switch-cuda-version)

## CUDA_VISIBLE_DEVICES

This variable specifies which GPU device can be used by user program. The default value of this variable is set to `0`, implying that the only GPU that can be used by any user program is GPU0. Currently, ELSA lab's compuatational platform supports up to 3 GPU devices. To select the GPU to run you program on, please set the value of this variable to either 0, 1, or 2 (if available).  

# Tensorflow Relate Variables

## TF_FORCE_GPU_ALLOW_GROWTH

If this variable decided whether a GPU is allowed to be shared by multiple processes. If the value of this variable is set to `false`, a GPU process will consume all of the VRAM available on the video card. As a result, other processes is unable to make use of the same GPU. In order to maximize the utilization of our GPUs, we set the value of this variable to `true` to allow processes to share the same GPU.