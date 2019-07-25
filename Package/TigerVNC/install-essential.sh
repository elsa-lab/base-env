#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# install web browser
sudo apt update
sudo apt install -y chromium-browser \
                    fonts-moe-standard-kai \
                    fonts-moe-standard-song

# install visual studio code
curl -L https://vscode.cdn.azure.cn/stable/2213894ea0415ee8c85c5eea0d0ff81ecc191529/code_1.36.1-1562627527_amd64.deb -o /tmp/vs-code.deb
sudo dpkg -i /tmp/vs-code.deb

# clean up
rm -f /tmp/vs-code.deb
