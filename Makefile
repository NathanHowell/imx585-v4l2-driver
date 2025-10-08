obj-m += imx585.o

KERNEL_SRC ?= /lib/modules/$(shell uname -r)/build
INSTALL_MOD_DIR ?= kernel/drivers/media/i2c

ccflags-y += -I$(src)/include -I$(KERNEL_SRC)/include -I$(KERNEL_SRC)/include/uapi

KBUILD_EXTRA_SYMBOLS += $(src)/Module.symvers

.PHONY: all modules modules_install clean

all: modules

modules:
	$(MAKE) -C $(KERNEL_SRC) M=$(CURDIR) modules

modules_install:
	$(MAKE) -C $(KERNEL_SRC) M=$(CURDIR) \
		INSTALL_MOD_DIR=$(INSTALL_MOD_DIR) modules_install

%.dtbo: %.dts
	dtc -@ -I dts -O dtb -o $@ $<
