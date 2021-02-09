#!/bin/bash
#=================================================
# File name: preset-terminal-tools.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: dhdaxcw
# Blog: www.baidu.com
#=================================================

mkdir -p files/root
pushd files/root

## Install oh-my-zsh
# Clone oh-my-zsh repository
git clone https://github.com/robbyrussell/oh-my-zsh ./.oh-my-zsh

# Install extra plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ./.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ./.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ./.oh-my-zsh/custom/plugins/zsh-completions

rm -rf friendlywrt/feeds/packages/libs/libcap
svn co https://github.com/openwrt/packages/trunk/libs/libcap friendlywrt/feeds/packages/libs/libcap
rm -rf friendlywrt/package/feeds/packages/netdata
svn co https://github.com/openwrt/packages/trunk/admin/netdata friendlywrt/package/feeds/packages/netdata
rm -rf friendlywrt/feeds/packages/libs/libnatpmp
svn co https://github.com/coolsnowwolf/packages/trunk/libs/libnatpmp friendlywrt/feeds/packages/libs/libnatpmp
          
rm -rf friendlywrt/feeds/packages/lang/luasec
svn co https://github.com/coolsnowwolf/packages/trunk/lang/luasec friendlywrt/feeds/packages/lang/luasec
sed -i '/STAMP_BUILT/d' friendlywrt/feeds/packages/utils/runc/Makefile
sed -i '/STAMP_BUILT/d' friendlywrt/feeds/packages/utils/containerd/Makefile
          
sed -i '/upx/d' friendlywrt/package/lean/frp/Makefile
          
wget -O friendlywrt/package/kernel/kmod-sched-cake/Makefile https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/kernel/kmod-sched-cake-oot/Makefile
wget -O friendlywrt/feeds/packages/libs/libxml2/Makefile https://raw.githubusercontent.com/coolsnowwolf/packages/master/libs/libxml2/Makefile
sed -i "/redirect_https/d" friendlywrt/package/network/services/uhttpd/files/uhttpd.config
sed -i '/Load Average/i\\t\t<tr><td width="33%"><%:CPU Temperature%></td><td><%=luci.sys.exec("cut -c1-2 /sys/class/thermal/thermal_zone0/temp")%><span>&#8451;</span></td></tr>' friendlywrt/feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
sed -i 's/pcdata(boardinfo.system or "?")/"ARMv8"/' friendlywrt/feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
sed -i 's/services/vpn/g' friendlywrt/package/feeds/luci/luci-app-openvpn/luasrc/controller/openvpn.lua
sed -i 's/resolv.conf.d\/resolv.conf.auto/resolv.conf.auto/g' friendlywrt/package/lean/luci-app-flowoffload/root/etc/init.d/flowoffload          
          
          
 sed -i '/done/imkfs.ext4 \/dev\/mmcblk0p2 && mkdir \/mnt\/mmcblk0p2 && mount \/dev\/mmcblk0p2 \/mnt\/mmcblk0p2 && mount \/dev\/mmcblk0p2 \/opt\n' ./friendlywrt/package/base-files/files/root/setup.sh
 # sed -i 's/\/root/\/mnt\/mmcblk0p2/g' ./friendlywrt/package/luci-app-r2sflasher/root/usr/bin/rom_flash

# Get .zshrc dotfile
cp $GITHUB_WORKSPACE/scripts/.zshrc .

popd
