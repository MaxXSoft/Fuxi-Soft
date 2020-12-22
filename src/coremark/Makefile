# sources & targets
COREMARK_SRC := $(call rwildcard, $(COREMARK_DIR), *.c)
COREMARK_SRC += $(call rwildcard, $(COREMARK_DIR), *.S)
$(call make_obj, COREMARK, $(COREMARK_SRC))
COREMARK_TARGET := $(BUILD_DIR)/coremark.elf

# compiler flags
CFLAGS := -I$(COREMARK_DIR) -DFLAGS_STR="\"$(CC)\""


.PHONY: all clean coremark

all: coremark

clean:
	-rm $(COREMARK_TARGET)
	-rm $(COREMARK_TARGET).*

coremark: $(COREMARK_TARGET)

$(COREMARK_TARGET): $(COREMARK_OBJ)
	$(info making CoreMark benchmark...)
	$(LD) -T$(LIB_DIR)/linker.ld -o $@ $^
	$(OBJD) $@ > $@.dump
	$(if $(filter 0, $(DEBUG)), $(STRIP) $@ -o $@)

include $(TOP_DIR)/rules.mk
