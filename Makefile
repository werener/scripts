# ---> Project management <--- #
PROJECTS = ltree

clean_prefix = clean
CLEANS = $(addprefix $(clean_prefix), $(PROJECTS))

run_prefix = run
RUNS = $(addprefix $(run_prefix), $(PROJECTS))

# ---> Compilation <--- #
CXX = g++
flags = -std=c++17 -Wall
source_collector := python3 collect_sources.py
MAKEFLAGS += --no-print-directory

# ---> Directories <--- #
src_dir = src
header_dir = include
target_dir = build

# ---> Build rules <--- #
.PHONY: $(PROJECTS)

$(PROJECTS):
	@echo "Making '$@'..."
	@$(MAKE) choose_project PROJECT=$@

choose_project:
	$(eval sources := $(shell $(source_collector) $(PROJECT)))
	$(eval objects := $(addprefix $(PROJECT)/$(target_dir)/, $(sources:.cpp=.o)))
	@echo Creating objects from:
	@$(MAKE) $(PROJECT)/$(target_dir)/$(PROJECT) objects="$(objects)" PROJECT=$(PROJECT)

# ---> Generics <--- #
$(PROJECT)/$(target_dir)/$(PROJECT): $(objects)
	@mkdir -p $(@D)
	@echo "\nCreating binary from:"
	@for obj in $(objects); do printf "\t%s\n" "$$obj"; done
	@$(CXX) $(flags) -I"$(PROJECT)/$(header_dir)" $^ -o $@

$(PROJECT)/$(target_dir)/%.o: $(PROJECT)/$(src_dir)/%.cpp
	@mkdir -p $(@D)
	@echo -n "\t$<\n"
	@$(CXX) $(flags) -I"$(PROJECT)/$(header_dir)" -c $< -o $@

# ---> Cleanup <--- #
cleanall:
	rm -rf */$(target_dir)/

$(CLEANS):
	$(eval project_name = $(subst $(clean_prefix),,$@))
	rm -rf $(project_name)/$(target_dir)/

# ---> Code running <--- #
$(RUNS): 
	$(eval binary_name = $(subst $(run_prefix),,$@))
	./$(binary_name)/$(target_dir)/$(binary_name) $(args)