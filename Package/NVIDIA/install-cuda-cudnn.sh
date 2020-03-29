#!/bin/sh

# useful variables
CUDA8_LINK="https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run"
CUDA8_INSTALLER="cuda_8.0.61_375.26_linux.run"

CUDA8_CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.1.2/cudnn-8.0-linux-x64-v7.1.tgz"
CUDA8_CUDNN7_TGZ="cudnn-8.0-linux-x64-v7.1.tgz"

CUDA9_LINK="https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run"
CUDA9_INSTALLER="cuda_9.0.176_384.81_linux.run"

CUDA9_CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.3.1/cudnn-9.0-linux-x64-v7.3.1.20.tgz"
CUDA9_CUDNN7_TGZ="cudnn-9.0-linux-x64-v7.3.1.20.tgz"

CUDA10_LINK="https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux"
CUDA10_INSTALLER="cuda_10.0.130_410.48_linux.run"

CUDA10_CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.5.0/cudnn-10.0-linux-x64-v7.5.0.56.tgz"
CUDA10_CUDNN7_TGZ="cudnn-10.0-linux-x64-v7.5.0.56.tgz"

CUDA10_1_LINK="http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run"
CUDA10_1_INSTALLER="cuda_10.1.243_418.87.00_linux.run"

CUDA10_1_CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.6.0/cudnn-10.1-linux-x64-v7.6.0.64.tgz"
CUDA10_1_CUDNN7_TGZ="cudnn-10.1-linux-x64-v7.6.0.64.tgz"

TEMP_PATH="/tmp/cuda-$(date | md5sum | awk '{print $1}')"

# change directory to TEMP_PATH
mkdir -p "${TEMP_PATH}"
cd "${TEMP_PATH}"

# download cuda installer
curl -L "${CUDA8_LINK}" -o "${CUDA8_INSTALLER}"
curl -L "${CUDA9_LINK}" -o "${CUDA9_INSTALLER}"
curl -L "${CUDA10_LINK}" -o "${CUDA10_INSTALLER}"
curl -L "${CUDA10_1_LINK}" -o "${CUDA10_1_INSTALLER}"
chmod +x "${CUDA8_INSTALLER}"
chmod +x "${CUDA9_INSTALLER}"
chmod +x "${CUDA10_INSTALLER}"
chmod +x "${CUDA10_1_INSTALLER}"

# download cudnn tgz
curl -LO "${CUDA8_CUDNN7_LINK}"
curl -LO "${CUDA9_CUDNN7_LINK}"
curl -LO "${CUDA10_CUDNN7_LINK}"
curl -LO "${CUDA10_1_CUDNN7_LINK}"

# extends the sudo timeout for another 15 minutes
sudo -v

# install cuda8 toolkit
sudo ./"${CUDA8_INSTALLER}" --silent --toolkit --override

# install cudnn library to cuda8 home
sudo tar --no-same-owner -xzf "${CUDA8_CUDNN7_TGZ}" -C /usr/local

# install cuda9 toolkit
sudo ./"${CUDA9_INSTALLER}" --silent --toolkit --override

# install cudnn library to cuda9 home
sudo tar --no-same-owner -xzf "${CUDA9_CUDNN7_TGZ}" -C /usr/local

# install cuda10 toolkit
sudo ./"${CUDA10_INSTALLER}" --silent --toolkit --override

# install cudnn library to cuda10 home
sudo tar --no-same-owner -xzf "${CUDA10_CUDNN7_TGZ}" -C /usr/local

# install cuda10.1 toolkit
sudo ./"${CUDA10_1_INSTALLER}" --silent --toolkit --override

# install cudnn library to cuda10 home
sudo tar --no-same-owner -xzf "${CUDA10_1_CUDNN7_TGZ}" -C /usr/local

# remove default symbloic link
sudo rm -f /usr/local/cuda

# provide switching function
echo '
#!/bin/sh

VERSION=$1
PREFIX="cuda-"
SOURCE="/usr/local/${PREFIX}${VERSION}"
  
if [ ! -d "${SOURCE}" ]; then
  echo "Info: $1 is an invalid version of CUDA"   
  echo "Usage: ${FUNCNAME[0]} <available version of CUDA>"
  echo -n "       (available versions:"
  for d in $(ls /usr/local); do
    if [[ "${d}" == ${PREFIX}* ]]; then
      echo -n "  ${d#${PREFIX}}"
    fi
  done
  echo ")"
else
  ln -s -f -n "${SOURCE}" "${CUDA_HOME}"
  echo "Info: Switch to CUDA $1"
fi
' | sudo tee /usr/local/bin/chcuda
sudo chmod +x /usr/local/bin/chcuda

# default use cuda-10.0
ln -n -f -s /usr/local/cuda-10.0 ~/.cuda
sudo ln -n -f -s /usr/local/cuda-10.0 /etc/skel/.cuda

# clean up
cd && rm -rf "${TEMP_PATH}"
