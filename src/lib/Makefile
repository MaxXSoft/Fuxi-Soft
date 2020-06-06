# sources & targets
LIB_SRC := $(call rwildcard, $(LIB_DIR), *.yu)
LIB_SRC += $(call rwildcard, $(LIB_DIR), *.cpp)
LIB_SRC += $(call rwildcard, $(LIB_DIR), *.S)
$(call make_obj, LIB, $(LIB_SRC))
LIB_TARGET := $(BUILD_DIR)/libfsrt.a

# compiler flags
YUCFLAGS := -I $(LIB_DIR)
CXXFLAGS := -I$(LIB_DIR)
ASFLAGS := -I$(LIB_DIR)


.PHONY: all clean lib

all: lib

clean:
	-rm $(LIB_TARGET)

lib: $(LIB_TARGET)

$(LIB_TARGET): $(LIB_OBJ)
	$(info making Fuxi SoC bare-metal software runtime library...)
	$(AR) $@ $^
	$(RANLIB) $@

include $(TOP_DIR)/rules.mk
