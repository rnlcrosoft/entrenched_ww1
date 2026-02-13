OBFUSCATOR = obfuscate.lua
CONCAT = concat.lua
MAIN_OUTPUT = main.lua
SRC_DIR = src
PUBLIC_DIR = public
SRC_FILES = $(wildcard $(SRC_DIR)/*.lua)
PUBLIC_FILES = $(patsubst $(SRC_DIR)/%.lua,$(PUBLIC_DIR)/%.lua,$(SRC_FILES))

.PHONY: all obfuscate concat clean

all: clean public concat

public: $(PUBLIC_FILES)

$(PUBLIC_DIR)/%.lua: $(SRC_DIR)/%.lua $(OBFUSCATOR)
	@mkdir -p $(PUBLIC_DIR)
	@echo "Obfuscating $< -> $@"
	@lua $(OBFUSCATOR) $< > $@

concat: public
	@echo "Concatenating files into $(MAIN_OUTPUT)..."
	@lua $(CONCAT)

clean:
	@echo "Cleaning public directory..."
	@rm -rf $(PUBLIC_DIR)/*.lua
