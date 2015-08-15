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
  DEPENDS:= +nodogsplash \
	+qmp-small-node \
	+luci-ssl \
	+wget \
	+reghack \
	+tinc
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
	$(INSTALL_DATA) ./files/etc/dropbear/authorized_keys $(1)/etc/dropbear/authorized_keys
 	$(INSTALL_DATA) ./files/etc/passwd $(1)/etc/passwd
 	$(INSTALL_DATA) ./files/etc/shadow $(1)/etc/shadow
	$(INSTALL_DIR) $(1)/etc/tinc/nycmesh/hosts
	$(INSTALL_DATA) ./files/etc/tinc/nycmesh/hosts/tunnelnycmesh $(1)/etc/tinc/nycmesh/hosts/tunnelnycmesh
	$(CP) ./files/etc/init.d/* $(1)/
        $(CP) ./files/etc/rc.d/* $(1)/


endef

$(eval $(call BuildPackage,qmp-nycmesh))
