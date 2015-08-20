# qmp-nycmesh openwrt package
#

include $(TOPDIR)/rules.mk

PKG_NAME:=qmp-nycmesh
PKG_VERSION:=1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/qmp-nycmesh
  SECTION:=utils
  CATEGORY:=qMp
  TITLE:=qMp nycmesh
  MAINTAINER:=nycmesh
  DEPENDS:=+nodogsplash \
	+qmp-small-node \
	+luci-ssl \
	+wget \
	+reghack \
	+tinc \
	+curl \
	+6in4
endef

define Package/qmp-nycmesh/description
 nycmesh confs
endef

define Build/Compile
endef

define Package/qmp-nycmesh/install
	 $(INSTALL_DIR) $(1)/etc/nycmesh
	 $(INSTALL_BIN) ./files/etc/nycmesh/nycmesh_conf.sh $(1)/etc/nycmesh/nycmesh_conf.sh
	 $(INSTALL_BIN) ./files/etc/nycmesh/check_tunnel.sh $(1)/etc/nycmesh/check_tunnel.sh
	 $(INSTALL_BIN) ./files/etc/nycmesh/tinc_conf.sh $(1)/etc/nycmesh/tinc_conf.sh
	 $(INSTALL_BIN) ./files/etc/nycmesh/tinc_putkey.sh $(1)/etc/nycmesh/tinc_putkey.sh
	 $(INSTALL_DIR) $(1)/etc/dropbear
	 $(INSTALL_DATA) ./files/etc/dropbear/authorized_keys $(1)/etc/dropbear/authorized_keys
	 $(CP) ./files/etc/passwd $(1)/etc/passwd
	 $(CP) ./files/etc/shadow $(1)/etc/shadow
	 $(INSTALL_DIR) $(1)/etc/tinc/nycmesh/hosts
	 $(INSTALL_DATA) ./files/etc/tinc/nycmesh/hosts/tunnelnycmesh $(1)/etc/tinc/nycmesh/hosts/tunnelnycmesh
	 $(INSTALL_DATA) ./files/etc/tinc/nycmesh/tinc-up $(1)/etc/tinc/nycmesh/tinc-up
	 $(INSTALL_DIR) $(1)/etc/init.d
	 $(INSTALL_DIR) $(1)/etc/rc.d
	 $(CP) ./files/etc/init.d/* $(1)/etc/init.d
	 $(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	 $(INSTALL_DATA) ./files/etc/hotplug.d/iface/95-nodog $(1)/etc/hotplug.d/iface/95-nodog
	 $(INSTALL_DIR) $(1)/etc/nodogsplash/htdocs
	 $(INSTALL_DATA) ./files/etc/nodogsplash/htdocs/splash.html $(1)/etc/nodogsplash/htdocs/splash.html
endef

$(eval $(call BuildPackage,qmp-nycmesh))
