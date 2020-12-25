# sources & targets
UNCOMP_SRC := $(call rwildcard, $(UNCOMP_DIR), *.yu)
UNCOMP_SRC += $(call rwildcard, $(UNCOMP_DIR), *.S)
$(call make_obj, UNCOMP, $(UNCOMP_SRC))
UNCOMP_TARGET := $(BUILD_DIR)/uncompressor.elf

# payload
PAYLOAD := $(UNCOMP_DIR)/payload.elf
COMPRESSOR := $(UNCOMP_DIR)/../../script/compress.py
COMPRESSED_PAYLOAD := $(BUILD_DIR)/payload.bin

# compiler flags
YUCFLAGS := -I $(SRC_DIR) -I $(UNCOMP_DIR)
ASFLAGS := -I$(BUILD_DIR)


.PHONY: all clean uncompressor

all: uncompressor

clean:
	-rm $(UNCOMP_TARGET)
	-rm $(UNCOMP_TARGET).*
	-rm $(COMPRESSED_PAYLOAD)

uncompressor: $(UNCOMP_TARGET)

$(UNCOMP_TARGET): $(UNCOMP_OBJ)
	$(info making uncompressor program...)
	$(LD) -T$(UNCOMP_DIR)/linker.ld -L$(BUILD_DIR) -lfsrt -o $@ $^
	$(OBJD) $@ > $@.dump
	$(if $(filter 0, $(DEBUG)), $(STRIP) $@ -o $@)

$(UNCOMP_DIR)/payload.S: $(COMPRESSED_PAYLOAD)

$(COMPRESSED_PAYLOAD): $(PAYLOAD) $(COMPRESSOR)
	$(COMPRESSOR) $< $@

include $(TOP_DIR)/rules.mk
