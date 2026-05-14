#!/usr/bin/env bash

# Copyright (c) 2021-2026 community-scripts ORG
# Author: Slaviša Arežina (tremor021)
# License: MIT | https://github.com/community-scripts/ProxmoxVED/raw/main/LICENSE
# Source: https://github.com/ether/etherpad

source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

NODE_VERSION=25 setup_nodejs
fetch_and_deploy_gh_release "etherpad" "ether/etherpad" "binary"

msg_info "Configuring Etherpad"
sed -i 's|"soffice": null|"soffice": "/usr/bin/libreoffice"|' /opt/etherpad/settings.json
msg_ok "Configured Etherpad"

systemctl start etherpad

motd_ssh
customize
cleanup_lxc
