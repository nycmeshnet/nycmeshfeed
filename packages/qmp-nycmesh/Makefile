#    Copyright (C) 2015 NYC Mesh, http://www.nycmesh.net
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
#    The full GNU General Public License is included in this distribution in
#    the file called "COPYING".
#
# Contributors:
#	Daniel J. Grinkevich
#


include $(TOPDIR)/rules.mk

PKG_NAME:=qmp-nycmesh
PKG_VERSION:=1
PKG_RELEASE:=1
PKG_LICENSE:=GPL-2.0+
NYCMESH_VERSION=$(cat ../../.git/refs/heads/master)

include $(INCLUDE_DIR)/package.mk

define Package/qmp-nycmesh
  SECTION:=utils
  CATEGORY:=qMp
  TITLE:=qMp NYC Mesh Configuration
  MAINTAINER:=NYC Mesh
  DEPENDS:=+nodogsplash \
	+qmp-small-node \
	+luci-ssl \
	+wget \
	+reghack \
	+tinc \
	+curl \
	+6in4 \
	+kmod-ipt-conntrack-extra \
	+gnupg
endef

define Package/qmp-nycmesh/description
 Configuration files for the NYC Mesh.
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
	 $(INSTALL_BIN) ./files/etc/tinc/nycmesh/tinc-up $(1)/etc/tinc/nycmesh/tinc-up
	 $(INSTALL_DIR) $(1)/etc/init.d
	 $(INSTALL_DIR) $(1)/etc/rc.d
	 $(CP) ./files/etc/init.d/* $(1)/etc/init.d
	 $(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	 $(INSTALL_DATA) ./files/etc/hotplug.d/iface/95-nodog $(1)/etc/hotplug.d/iface/95-nodog
	 $(INSTALL_DIR) $(1)/etc/nodogsplash/htdocs
	 $(INSTALL_DATA) ./files/etc/nodogsplash/htdocs/splash.html $(1)/etc/nodogsplash/htdocs/splash.html
	 $(SED) 's,$$$$VERSION,$(NYCMESH_VERSION),g' $(1)/etc/nycmesh.banner
endef

$(eval $(call BuildPackage,qmp-nycmesh))
