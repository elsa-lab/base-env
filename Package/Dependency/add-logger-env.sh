#!/bin/sh

echo "export PROMPT_COMMAND='history -a >(tee -a ~/.bash_history | logger -t \"\$USER[\$\$] \$SSH_CONNECTION\")'" |
  sudo tee /etc/profile.d/logger.sh
