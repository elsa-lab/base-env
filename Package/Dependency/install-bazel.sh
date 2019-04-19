#!/bin/bash

# extends the sudo timeout for another 15 minutes
sudo -v

# Install JDK 8
sudo apt install -y openjdk-8-jdk

# Add Bazel distribution URI as a package source
echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -

# Install and update Bazel
sudo apt update && sudo apt install -y bazel
