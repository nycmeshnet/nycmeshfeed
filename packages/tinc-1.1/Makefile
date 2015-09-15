
# Copyright (C) 2007-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tinc-1.1
PKG_VERSION:=pre11
PKG_RELEASE:=1

PKG_SOURCE:=tinc-1.1$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.tinc-vpn.org/packages
#PKG_SOURCE_SUBDIR:=$(PKG_NAME)$(PKG_VERSION)
PKG_BUILD_DIR:= $(BUILD_DIR)/$(PKG_NAME)$(PKG_VERSION)

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/tinc-1.1
  SECTION:=utils
  CATEGORY:=qMp
  DEPENDS:=+liblzo +libopenssl +kmod-tun +libreadline +libncurses
  TITLE:=VPN tunneling daemon
  URL:=http://www.tinc-vpn.org/
  MAINTAINER:=Saverio Proto <zioproto@gmail.com>
  SUBMENU:=VPN
endef

define Package/tinc-1.1/description
  tinc is a Virtual Private Network (VPN) daemon that uses tunnelling and
  encryption to create a secure private network between hosts on the Internet.
endef

TARGET_CFLAGS += -std=gnu99

CONFIGURE_ARGS += \
	--with-kernel="$(LINUX_DIR)" \
	--with-zlib="$(STAGING_DIR)/usr" \
	--with-lzo-include="$(STAGING_DIR)/usr/include/lzo"

define Package/tinc-1.1/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/tincd $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/tinc $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) files/tinc.init $(1)/etc/init.d/tinc
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/tinc.config $(1)/etc/config/tinc
	$(INSTALL_DIR) $(1)/etc/tinc
	$(INSTALL_DIR) $(1)/lib/upgrade/keep.d
	$(INSTALL_DATA) files/tinc.upgrade $(1)/lib/upgrade/keep.d/tinc
endef

define Package/tinc-1.1/conffiles
/etc/config/tinc
endef

$(eval $(call BuildPackage,tinc-1.1))
