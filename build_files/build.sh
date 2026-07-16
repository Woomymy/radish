#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Add 45drives repo
cat << EOF > /etc/yum.repos.d/45drives.repo
[45drives_enterprise]
enabled = 1
priority = 1
gpgcheck = 1
repo_gpgcheck = 1
baseurl = https://repo.45drives.com/enterprise/rocky/el8/stable
gpgkey = https://repo.45drives.com/key/gpg.asc
name = 45Drives Enterprise 8 Repo
EOF

# this installs a package from fedora repos
dnf5 install -y borgbackup cockpit-file-sharing

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
