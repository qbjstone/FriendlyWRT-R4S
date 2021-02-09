#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# Add luci-app-ssr-plus
pushd package/lean
git clone --depth=1 https://github.com/fw876/helloworld
popd

# Clone community packages to package/community
mkdir package/community
pushd package/community

# Add Lienol's Packages
git clone --depth=1 https://github.com/Lienol/openwrt-package

# Add luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

# Add luci-app-vssr <M>
git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb.git
git clone --depth=1 https://github.com/jerrykuku/luci-app-vssr

# Add mentohust & luci-app-mentohust
git clone --depth=1 https://github.com/BoringCat/luci-app-mentohust
git clone --depth=1 https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk

# Add ServerChan
git clone --depth=1 https://github.com/tty228/luci-app-serverchan

# Add OpenClash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash

# Add luci-app-onliner (need luci-app-nlbwmon)
git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner

# Add luci-app-adguardhome
svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome
svn co https://github.com/Lienol/openwrt/trunk/package/diy/adguardhome

# Add luci-app-diskman
git clone --depth=1 https://github.com/SuLingGG/luci-app-diskman
mkdir parted
cp luci-app-diskman/Parted.Makefile parted/Makefile

# Add luci-app-dockerman
rm -rf ../lean/luci-app-docker
git clone --depth=1 https://github.com/KFERMercer/luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-lib-docker

# Add luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../lean/luci-theme-argon

# Add subconverter
git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter

# Add smartdns
svn co https://github.com/pymumu/smartdns/trunk/package/openwrt ../smartdns
svn co https://github.com/pymumu/luci-app-smartdns/trunk ../luci-app-smartdns

# Add luci-udptools
git clone --depth=1 https://github.com/zcy85611/openwrt-luci-kcp-udp

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

# Add OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter
popd

# Mod zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
export orig_version="$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')"
sed -i "s/${orig_version}/${orig_version} ($(date +"%Y.%m.%d"))/g" zzz-default-settings
popd

# Fix libssh
pushd feeds/packages/libs
rm -rf libssh
svn co https://github.com/openwrt/packages/trunk/libs/libssh
popd

# Use Lienol's https-dns-proxy package
pushd feeds/packages/net
rm -rf https-dns-proxy
svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy
popd

# Use snapshots syncthing package
pushd feeds/packages/utils
rm -rf syncthing
svn co https://github.com/openwrt/packages/trunk/utils/syncthing
popd

# Fix mt76 wireless driver
pushd package/kernel/mt76
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
popd

# Add po2lmo
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd

# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd


# Custom configs
# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

echo -e " Lean's OpenWrt built on "$(date +%Y.%m.%d)"\n -----------------------------------------------------" >> package/base-files/files/etc/banner

pushd package/lean
rm -rf autocore
svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/lean/autocore
popd
