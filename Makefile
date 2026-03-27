# ---> Project management <--- #
PROJECTS = ltree

clean_prefix = clean
CLEANS = $(addprefix $(clean_prefix), $(PROJECTS))

run_prefix = run
RUNS = $(addprefix $(run_prefix), $(PROJECTS))

MAKEFLAGS += --no-print-directory

# ---> Build rules <--- #
.PHONY: $(PROJECTS)

$(PROJECTS):
	@echo "Making '$@'...\n"
	@$(MAKE) -C $@ build

# ---> Cleanup <--- #
cleanall:
	rm -rf */$(target_dir)/

$(CLEANS):
	$(eval project_name = $(subst $(clean_prefix),,$@))
	@echo "Removing '$(project_name)'...\n"
	@$(MAKE) -C $(project_name) clean

# ---> Code running <--- #
$(RUNS): 
	$(eval binary_name = $(subst $(run_prefix),,$@))
	@echo "Running '$(binary_name)'...\n"
	@$(MAKE) -C $(binary_name) run