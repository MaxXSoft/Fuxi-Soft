# toolchain
include toolchain.mk

# helper functions
export rwildcard = $$(foreach d, $$(wildcard $$(1:=/*)), $$(call rwildcard, $$d, $$2) $$(filter $$(subst *, %, $$2), $$d))
define make_obj
	$$(eval TEMP := $$(patsubst $(TOP_DIR)/%.yu, $(OBJ_DIR)/%.yu.o, $$(2)));
	$$(eval TEMP := $$(patsubst $(TOP_DIR)/%.c, $(OBJ_DIR)/%.c.o, $$(TEMP)));
	$$(eval TEMP := $$(patsubst $(TOP_DIR)/%.cpp, $(OBJ_DIR)/%.cpp.o, $$(TEMP)));
	$$(eval TEMP := $$(patsubst $(TOP_DIR)/%.S, $(OBJ_DIR)/%.S.o, $$(TEMP)));
	$$(eval $$(1)_OBJ := $$(TEMP));
endef
export make_obj

# directories
export TOP_DIR := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
export BUILD_DIR := $(TOP_DIR)/build
export SRC_DIR := $(TOP_DIR)/src
export LIB_DIR := $(SRC_DIR)/lib
export SLIDE_DIR := $(SRC_DIR)/slideshow
export STOPWATCH_DIR := $(SRC_DIR)/stopwatch
export PLAYER_DIR := $(SRC_DIR)/player
export TETRIS_DIR := $(SRC_DIR)/tetris
export UNCOMP_DIR := $(SRC_DIR)/uncompressor
export DHRY_DIR := $(SRC_DIR)/dhry
export COREMARK_DIR := $(SRC_DIR)/coremark
export OBJ_DIR := $(BUILD_DIR)/obj

# all sub-makes
SUB_MAKE := $(LIB_DIR) $(SLIDE_DIR) $(STOPWATCH_DIR) $(PLAYER_DIR)
SUB_MAKE += $(TETRIS_DIR) $(UNCOMP_DIR) $(DHRY_DIR) $(COREMARK_DIR)


.SILENT:
.PHONY: all clean lib slideshow stopwatch player tetris uncompressor dhry coremark $(SUB_MAKE)

all: lib slideshow stopwatch player tetris uncompressor dhry coremark

clean:
	$(info cleaning...)
	-rm -rf $(OBJ_DIR)
	-$(MAKE) -C $(LIB_DIR) $@
	-$(MAKE) -C $(SLIDE_DIR) $@
	-$(MAKE) -C $(STOPWATCH_DIR) $@
	-$(MAKE) -C $(PLAYER_DIR) $@
	-$(MAKE) -C $(TETRIS_DIR) $@
	-$(MAKE) -C $(UNCOMP_DIR) $@
	-$(MAKE) -C $(DHRY_DIR) $@
	-$(MAKE) -C $(COREMARK_DIR) $@

lib: $(BUILD_DIR) $(LIB_DIR)

slideshow: $(BUILD_DIR) $(SLIDE_DIR)

stopwatch: $(BUILD_DIR) $(STOPWATCH_DIR)

player: $(BUILD_DIR) $(PLAYER_DIR)

tetris: $(BUILD_DIR) $(TETRIS_DIR)

uncompressor: $(BUILD_DIR) $(UNCOMP_DIR)

dhry: $(BUILD_DIR) $(DHRY_DIR)

coremark: $(BUILD_DIR) $(COREMARK_DIR)

$(SUB_MAKE):
	$(MAKE) -C $@ $(MAKECMDGOALS)

$(SLIDE_DIR): $(LIB_DIR)

$(STOPWATCH_DIR): $(LIB_DIR)

$(PLAYER_DIR): $(LIB_DIR)

$(TETRIS_DIR): $(LIB_DIR)

$(UNCOMP_DIR): $(LIB_DIR)

$(BUILD_DIR):
	mkdir $@
