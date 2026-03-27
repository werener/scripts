# ---> Compilation <--- #
CXX = g++
flags = -std=c++20 -Wall
source_collector := python3 ../collect_sources.py
project_name = ltree

# ---> Directories <--- #
src_dir = src
header_dir = include
target_dir = build

# ---> Files <--- #
sources := $(shell $(source_collector) .)
objects := $(addprefix $(target_dir)/, $(sources:.cpp=.o))

# ---> Main commands <--- #
main: build

build: $(target_dir)/$(project_name)
	@echo "\nSuccess!"
.PHONY: build

clean:
	rm -rf $(target_dir)/

run: build
	./$(target_dir)/$(project_name)

# ---> Generics <--- #
$(target_dir)/$(project_name): $(objects)
	@mkdir -p $(@D)
	@echo "\nCreating binary from:"
	@for obj in $(objects); do printf "\t%s\n" "$$obj"; done
	
	@$(CXX) $(flags) -I"$(header_dir)" $^ -o $@

$(target_dir)/%.o: $(src_dir)/%.cpp
	@mkdir -p $(@D)
	@echo "Object renewed:\t$<"

	@$(CXX) $(flags) -I"$(header_dir)" -c $< -o $@

hey:
	@echo "\nCreating binary from:"
	@echo "$(sources)"
	@echo "$(objects)"