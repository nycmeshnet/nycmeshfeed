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
	+wget

endef

define Package/qmp-nycmesh/description
 nycmesh confs
endef

define Build/Compile
endef

define Package/qmp-nycmesh/install
	$(INSTALL_DIR) $(1)/etc/nycmesh
	$(INSTALL_DATA) ./files/etc/nycmesh/nycmesh.sh $(1)/etc/nycmesh/nycmesh.sh
endef

$(eval $(call BuildPackage,qmp-nycmesh))
