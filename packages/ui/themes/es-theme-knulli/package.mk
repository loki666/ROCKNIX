# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-24 JELOS (https://github.com/JustEnoughLinuxOS)
# Copyright (C) 2024-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="es-theme-knulli"
PKG_VERSION="3f25460d3f1c12bde5a6aecd52679a214aae4d74"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/symbuzzer/es-theme-knulli"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="es-theme-knulli"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/themes/${PKG_NAME}
  cp -rf * ${INSTALL}/usr/share/themes/${PKG_NAME}
  
  THEME_FILE="${INSTALL}/usr/share/themes/${PKG_NAME}/theme.xml"
  
  if [[ -f "${THEME_FILE}" ]]; then
    sed -i -e '
      /<include name="knulli" displayName="\${subset.themeColors.knulli}" >\.\/_inc\/variables\/themeColors-knulli\.xml<\/include>/{
        h
        s|<include name="knulli" displayName="${subset.themeColors.knulli}" >./_inc/variables/themeColors-knulli.xml</include>|<include name="rocknix" displayName="${subset.themeColors.rocknix}" >./_inc/variables/themeColors-rocknix.xml</include>|
        x
      }
      /<include name="rocknix" displayName="\${subset.themeColors.rocknix}" >\.\/_inc\/variables\/themeColors-rocknix\.xml<\/include>/{
        s|<include name="rocknix" displayName="${subset.themeColors.rocknix}" >./_inc/variables/themeColors-rocknix.xml</include>|<include name="knulli" displayName="${subset.themeColors.knulli}" >./_inc/variables/themeColors-knulli.xml</include>|
        G
      }
    ' "${THEME_FILE}"
  else
    echo "not found: ${THEME_FILE}"
  fi
}

