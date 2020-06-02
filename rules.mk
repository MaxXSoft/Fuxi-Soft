$(OBJ_DIR)/%.yu.ll: $(TOP_DIR)/%.yu
	$(info YUC $@)
	-mkdir -p $(dir $@)
	$(YUC) $(YUCFLAGS) -ot llvm $^ > $@

$(OBJ_DIR)/%.cpp.o: $(TOP_DIR)/%.cpp
	$(info CXX $@)
	-mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -o $@ $^

$(OBJ_DIR)/%.S.o: $(TOP_DIR)/%.S
	$(info AS  $@)
	-mkdir -p $(dir $@)
	$(CXX) $(ASFLAGS) -o $@ $^

$(OBJ_DIR)/%.o: $(OBJ_DIR)/%.ll
	$(info LLC $@)
	$(LLC) $(LLCFLAGS) $^ -o $@
