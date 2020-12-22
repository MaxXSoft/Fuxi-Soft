# sources & targets
SLIDE_SRC := $(call rwildcard, $(SLIDE_DIR), *.yu)
SLIDE_SRC += $(call rwildcard, $(SLIDE_DIR), *.cpp)
$(call make_obj, SLIDE, $(SLIDE_SRC))
SLIDE_TARGET := $(BUILD_DIR)/slide.elf

# compiler flags
YUCFLAGS := -I $(SRC_DIR) -I $(SLIDE_DIR)
CXXFLAGS := -I$(SRC_DIR) -I$(SLIDE_DIR)


.PHONY: all clean slideshow

all: slideshow

clean:
	-rm $(SLIDE_TARGET)
	-rm $(SLIDE_TARGET).*

slideshow: $(SLIDE_TARGET)

$(SLIDE_TARGET): $(SLIDE_OBJ)
	$(info making slideshow program...)
	$(LD) -T$(LIB_DIR)/linker.ld -L$(BUILD_DIR) -lfsrt -o $@ $^
	$(OBJD) $@ > $@.dump
	$(if $(filter 0, $(DEBUG)), $(STRIP) $@ -o $@)

include $(TOP_DIR)/rules.mk
