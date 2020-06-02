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
export OBJ_DIR := $(BUILD_DIR)/obj

# all sub-makes
SUB_MAKE := $(LIB_DIR) $(SLIDE_DIR)


.SILENT:
.PHONY: all clean lib slideshow $(SUB_MAKE)

all: lib slideshow

clean:
	$(info cleaning...)
	-rm -rf $(OBJ_DIR)
	-$(MAKE) -C $(LIB_DIR) $@
	-$(MAKE) -C $(SLIDE_DIR) $@

lib: $(BUILD_DIR) $(LIB_DIR)

slideshow: $(BUILD_DIR) $(SLIDE_DIR)

$(SUB_MAKE):
	$(MAKE) -C $@ $(MAKECMDGOALS)

$(SLIDE_DIR): $(LIB_DIR)

$(BUILD_DIR):
	mkdir $@
