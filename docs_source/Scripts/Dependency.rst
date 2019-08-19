Dependency
============

Introduction
---------------
This page is going to introduce the ``install-essentail.sh`` used to install the apt package.

Packages Intro.
---------------

.. code-block:: bash

    smartmontools dkms \
    htop iotop smem \

``smartmontools`` is used to 讀取硬碟 S.M.A.R.T. 資訊. (e.g., hard disk health ...). 
``dkms`` 為一個 Linux 驅動安裝的管理機制，讓 user 不需要再檔案系統中尋找 driver 的原始碼並編譯，更可以於 load kernel 時自動檢查要不要編譯這個 driver. 
``iotop`` is used to 監看每支程式讀寫硬碟的情形. 
``smem`` is a tool that can give numerous reports on memory usage on Linux systems. 

.. code-block:: bash

    build-essential cmake \
    curl wget \
    landscape-common \

``build-essential`` contains an informational list of packages which are considered essential for building Debian packages. 
``curl`` and ``wget`` is used for transferring data using various protocols. 
``landscape-common`` includes lots of basic commands for Ubuntu. (e.g., adduser, ca-certificates, python 2.7). 


.. code-block:: bash

    ppa-purge \

``ppa``, or Personal Package Archive, provides some package developmented by users, not official.
``ppa-purge`` is a commands for not only removing the PPA but also uninstalling all the programs installed by the PPA.


.. code-block:: bash

    fail2ban sshfs \
    ffmpeg \

``fail2ban`` 防範暴力破解 (SSH、vsftp、dovecot、sendmail). 
``ffmpeg`` is used for mulitmedia 錄影、轉檔、串流功能


.. code-block:: bash

    libosmesa6-dev \
    libgl1-mesa-dev \
    libopenmpi-dev \
    libopenblas-dev \

