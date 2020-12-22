# sources & targets
STOPWATCH_SRC := $(call rwildcard, $(STOPWATCH_DIR), *.yu)
$(call make_obj, STOPWATCH, $(STOPWATCH_SRC))
STOPWATCH_TARGET := $(BUILD_DIR)/stopwatch.elf

# compiler flags
YUCFLAGS := -I $(SRC_DIR) -I $(STOPWATCH_DIR)
CXXFLAGS := -I$(SRC_DIR) -I$(STOPWATCH_DIR)


.PHONY: all clean stopwatch

all: stopwatch

clean:
	-rm $(STOPWATCH_TARGET)
	-rm $(STOPWATCH_TARGET).*

stopwatch: $(STOPWATCH_TARGET)

$(STOPWATCH_TARGET): $(STOPWATCH_OBJ)
	$(info making stopwatch program...)
	$(LD) -T$(LIB_DIR)/linker.ld -L$(BUILD_DIR) -lfsrt -o $@ $^
	$(OBJD) $@ > $@.dump
	$(if $(filter 0, $(DEBUG)), $(STRIP) $@ -o $@)

include $(TOP_DIR)/rules.mk
