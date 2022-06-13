################################################################################
#
# rpi-distro-firmware-nonfree
#
################################################################################

RPI_DISTRO_FIRMWARE_NONFREE_VERSION = 4db8c5d80daf2220d7824cfa6052f0bb108612ea # 20210315-3+rpt5 + RPI Zero 2W update
RPI_DISTRO_FIRMWARE_NONFREE_SITE = $(call github,RPi-Distro,firmware-nonfree,$(RPI_DISTRO_FIRMWARE_NONFREE_VERSION))
RPI_DISTRO_FIRMWARE_NONFREE_LICENSE_FILES = debian/config/brcm80211/copyright

# The brcmfmac43436f-sdio symlinks come from the firmware-brcm80211.postinst script
define RPI_DISTRO_FIRMWARE_NONFREE_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/brcm
	for f in  $(@D)/debian/config/brcm80211/brcm/*; do \
		$(INSTALL) -D -m 0644 "$${f}" "$(TARGET_DIR)/lib/firmware/brcm/$${f##*/}" || exit 1; \
	done; \
	ln -sf brcmfmac43436f-sdio.bin "$(TARGET_DIR)/lib/firmware/brcm/brcmfmac43436-sdio.bin"; \
	ln -sf brcmfmac43436f-sdio.txt "$(TARGET_DIR)/lib/firmware/brcm/brcmfmac43436-sdio.txt"
endef

$(eval $(generic-package))
