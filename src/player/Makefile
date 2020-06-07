# sources & targets
PLAYER_SRC := $(call rwildcard, $(PLAYER_DIR), *.yu)
$(call make_obj, PLAYER, $(PLAYER_SRC))
PLAYER_TARGET := $(BUILD_DIR)/player.elf

# compiler flags
YUCFLAGS := -I $(SRC_DIR) -I $(PLAYER_DIR)
CXXFLAGS := -I$(SRC_DIR) -I$(PLAYER_DIR)


.PHONY: all clean player

all: player

clean:
	-rm $(PLAYER_TARGET)
	-rm $(PLAYER_TARGET).*

player: $(PLAYER_TARGET)

$(PLAYER_TARGET): $(PLAYER_OBJ)
	$(info making player program...)
	$(LD) -T$(LIB_DIR)/linker.ld -L$(BUILD_DIR) -lfsrt -o $@ $^
	$(OBJD) $@ > $@.dump

include $(TOP_DIR)/rules.mk
