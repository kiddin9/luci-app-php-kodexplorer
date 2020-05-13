include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-php-kodexplorer
PKG_VERSION:=2.0
PKG_RELEASE:=20200331

PKG_SOURCE_PROTO:=git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/kalcaddle/KodExplorer.git
PKG_SOURCE_VERSION:=latest
PKG_MAINTAINER:=GaryPang <https://github.com/garypang13/luci-app-php-kodexplorer> Lienol <lawlienol@gmail.com>

include $(TOPDIR)/feeds/luci/luci.mk

define Package/luci-app-php-kodexplorer
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI for PHP and KodExplorer
	PKG_MAINTAINER:=GaryPang
	PKGARCH:=all
	DEPENDS:=+luci-ssl-nginx +php7 +php7-fpm +php7-mod-curl +php7-mod-gd +php7-mod-iconv +php7-mod-json +php7-mod-mbstring +php7-mod-opcache +php7-mod-session +php7-mod-zip +php7-mod-sqlite3 +php7-mod-openssl
endef

define Package/luci-app-php-kodexplorer/extra_provides
    echo 'libstdc++.so.6'; \
    echo 'libpthread.so.0'; \
    echo 'libm.so.6'; \
    echo 'libc.so.6';
endef

define Build/Compile
endef

define Package/luci-app-php-kodexplorer/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	if [ -d "./luasrc" ]; then \
		cp -pR ./luasrc/* $(1)/usr/lib/lua/luci/; \
	fi
	$(INSTALL_DIR) $(1)/
	cp -pR ./root/* $(1)/
	
	$(INSTALL_DIR) $(1)/www/kod
	$(CP) \
		$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)/{app,config,data,plugins,static} \
		$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)/index.php \
		$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)/ChangeLog.md \
		$(1)/www/kod
endef

$(eval $(call BuildPackage,luci-app-php-kodexplorer))
