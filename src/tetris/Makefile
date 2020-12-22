# sources & targets
TETRIS_SRC := $(call rwildcard, $(TETRIS_DIR), *.yu)
$(call make_obj, TETRIS, $(TETRIS_SRC))
TETRIS_TARGET := $(BUILD_DIR)/tetris.elf

# compiler flags
YUCFLAGS := -I $(SRC_DIR) -I $(TETRIS_DIR)
CXXFLAGS := -I$(SRC_DIR) -I$(TETRIS_DIR)


.PHONY: all clean tetris

all: tetris

clean:
	-rm $(TETRIS_TARGET)
	-rm $(TETRIS_TARGET).*

tetris: $(TETRIS_TARGET)

$(TETRIS_TARGET): $(TETRIS_OBJ)
	$(info making tetris program...)
	$(LD) -T$(LIB_DIR)/linker.ld -L$(BUILD_DIR) -lfsrt -o $@ $^
	$(OBJD) $@ > $@.dump
	$(if $(filter 0, $(DEBUG)), $(STRIP) $@ -o $@)

include $(TOP_DIR)/rules.mk
