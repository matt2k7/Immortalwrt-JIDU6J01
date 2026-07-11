#!/bin/bash
set -euo pipefail

# Run from inside the immortalwrt directory (patch branch already checked out)

./scripts/feeds update -a
./scripts/feeds install -a

# Create .config
cat > .config <<'EOF'
CONFIG_TARGET_mediatek=y
CONFIG_TARGET_mediatek_filogic=y
CONFIG_TARGET_MULTI_PROFILE=y
CONFIG_TARGET_DEVICE_mediatek_filogic_DEVICE_jiorouter_ax6000-jidu6j01=y
CONFIG_TARGET_DEVICE_PACKAGES_mediatek_filogic_DEVICE_jiorouter_ax6000-jidu6j01=""
CONFIG_TARGET_PER_DEVICE_ROOTFS=y
CONFIG_FEED_luci=y
CONFIG_FEED_packages=y
CONFIG_FEED_routing=y
CONFIG_FEED_telephony=y
CONFIG_FEED_video=y
# Requested packages
CONFIG_PACKAGE_luci=y
CONFIG_PACKAGE_luci-app-mwan3=y
CONFIG_PACKAGE_ethtool=y
CONFIG_PACKAGE_luci-proto-wireguard=y
CONFIG_PACKAGE_wireguard-tools=y
CONFIG_PACKAGE_kmod-wireguard=y
CONFIG_PACKAGE_btop=y
CONFIG_PACKAGE_bmon=y
# Useful extras
CONFIG_PACKAGE_kmod-usb-storage=y
CONFIG_PACKAGE_kmod-fs-ext4=y
CONFIG_PACKAGE_kmod-fs-vfat=y
CONFIG_PACKAGE_block-mount=y
CONFIG_PACKAGE_kmod-usb-net-rndis=y
CONFIG_PACKAGE_kmod-usb-net-cdc-ether=y
CONFIG_PACKAGE_luci-app-statistics=y
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_nano=y
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_wget=y
CONFIG_PACKAGE_openssh-sftp-server=y
CONFIG_PACKAGE_kmod-tun=y
CONFIG_PACKAGE_luci-app-openvpn=y
CONFIG_PACKAGE_luci-app-ddns=y
CONFIG_PACKAGE_sqm-scripts=y
CONFIG_PACKAGE_luci-app-sqm=y
CONFIG_PACKAGE_irqbalance=y
EOF

make defconfig
make "-j$(nproc)"

echo "Build finished. Artifacts:"
ls -lha bin/targets/mediatek/filogic/
