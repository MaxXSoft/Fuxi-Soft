# sources & targets
DHRY_SRC := $(call rwildcard, $(DHRY_DIR), *.c)
DHRY_SRC += $(call rwildcard, $(DHRY_DIR), *.S)
$(call make_obj, DHRY, $(DHRY_SRC))
DHRY_TARGET := $(BUILD_DIR)/dhry.elf

# compiler flags
CFLAGS := -Wno-implicit-function-declaration -I$(DHRY_DIR)
CFLAGS += -DTIME -DPRINTF_DISABLE_SUPPORT_FLOAT
CFLAGS += -DPRINTF_DISABLE_SUPPORT_EXPONENTIAL
CFLAGS += -DPRINTF_DISABLE_SUPPORT_LONG_LONG
CFLAGS += -DPRINTF_DISABLE_SUPPORT_PTRDIFF_T


.PHONY: all clean dhry

all: dhry

clean:
	-rm $(DHRY_TARGET)
	-rm $(DHRY_TARGET).*

dhry: $(DHRY_TARGET)

$(DHRY_TARGET): $(DHRY_OBJ)
	$(info making Dhrystone 2.1 benchmark...)
	$(LD) -T$(LIB_DIR)/linker.ld -o $@ $^
	$(OBJD) $@ > $@.dump
	$(if $(filter 0, $(DEBUG)), $(STRIP) $@ -o $@)

include $(TOP_DIR)/rules.mk
