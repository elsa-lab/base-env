export ROCM_HOME="${HOME}/.rocm"
export PATH="$ROCM_HOME/bin:$PATH$"
export LD_LIBRARY_PATH="$ROCM_HOME/lib:$ROCM_HOME/lib64:$LD_LIBRARY_PATH"
export HIP_VISIBLE_DEVICES=0
complete -W "$(ls -d /opt/rocm-* 2> /dev/null | sed 's/\/opt\/rocm-//g')" chrocm

