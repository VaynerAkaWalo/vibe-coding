SHELL := /bin/zsh
REPO_DIR     := $(shell git rev-parse --show-toplevel)
OPENCODE_DIR := $(HOME)/.config/opencode
OPENCODE     := opencode/opencode.jsonc:opencode.jsonc opencode/AGENTS.md:AGENTS.md

.PHONY: install status clean

status:
	@echo "Config: $(OPENCODE_DIR)"
	@echo "Repo:    $(REPO_DIR)"
	@echo ""
	@echo "opencode:"
	@for item in $(OPENCODE); do \
		src=$${item%%:*}; dst=$${item##*:}; \
		link="$(OPENCODE_DIR)/$$dst"; expected="$(REPO_DIR)/$$src"; \
		printf "  %-20s " "$$dst"; \
		if [ -L "$$link" ]; then \
			current=$$(readlink "$$link"); \
			if [ "$$current" = "$$expected" ]; then \
				printf "\033[32m[linked]\033[0m\n"; \
			else \
				printf "\033[33m[wrong target]\033[0m\n"; \
			fi; \
		elif [ -e "$$link" ]; then \
			printf "\033[31m[conflict]\033[0m\n"; \
		else \
			printf "\033[90m[missing]\033[0m\n"; \
		fi; \
	done
	@echo ".agents:"
	@for skill in $(REPO_DIR)/.agents/skills/*/; do \
		[ -d "$$skill" ] || continue; \
		name=$$(basename "$$skill"); \
		link="$(OPENCODE_DIR)/skills/$$name"; \
		printf "  %-20s " "$$name"; \
		if [ -L "$$link" ]; then \
			current=$$(readlink "$$link"); \
			if [ "$$current" = "$$skill" ]; then \
				printf "\033[32m[linked]\033[0m\n"; \
			else \
				printf "\033[33m[wrong target]\033[0m\n"; \
			fi; \
		elif [ -d "$$link" ]; then \
			printf "\033[31m[conflict]\033[0m\n"; \
		else \
			printf "\033[90m[missing]\033[0m\n"; \
		fi; \
	done

install: check-dir
	@echo "opencode:"
	@for item in $(OPENCODE); do \
		src=$${item%%:*}; dst=$${item##*:}; \
		link="$(OPENCODE_DIR)/$$dst"; expected="$(REPO_DIR)/$$src"; \
		if [ -L "$$link" ]; then \
			current=$$(readlink "$$link"); \
			if [ "$$current" = "$$expected" ]; then \
				printf "  %-20s \033[32m[ok]\033[0m\n" "$$dst"; \
			else \
				printf "  %-20s \033[33m[fix]\033[0m\n" "$$dst"; \
				ln -sfn "$$expected" "$$link"; \
			fi; \
		elif [ -e "$$link" ]; then \
			printf "  %-20s \033[31m[skip]\033[0m\n" "$$dst"; \
		else \
			printf "  %-20s \033[34m[link]\033[0m\n" "$$dst"; \
			ln -s "$$expected" "$$link"; \
		fi; \
	done
	@mkdir -p "$(OPENCODE_DIR)/skills"
	@echo ".agents:"
	@for skill in $(REPO_DIR)/.agents/skills/*/; do \
		[ -d "$$skill" ] || continue; \
		name=$$(basename "$$skill"); \
		link="$(OPENCODE_DIR)/skills/$$name"; \
		if [ -L "$$link" ]; then \
			current=$$(readlink "$$link"); \
			if [ "$$current" = "$$skill" ]; then \
				printf "  %-20s \033[32m[ok]\033[0m\n" "$$name"; \
			else \
				printf "  %-20s \033[33m[fix]\033[0m\n" "$$name"; \
				ln -sfn "$$skill" "$$link"; \
			fi; \
		elif [ -d "$$link" ]; then \
			printf "  %-20s \033[31m[skip]\033[0m\n" "$$name"; \
		else \
			printf "  %-20s \033[34m[link]\033[0m\n" "$$name"; \
			ln -s "$$skill" "$$link"; \
		fi; \
	done

check-dir:
	@if [ ! -d "$(OPENCODE_DIR)" ]; then \
		printf "\033[34m  [dir]\033[0m creating $(OPENCODE_DIR)\n"; \
		mkdir -p "$(OPENCODE_DIR)"; \
	fi

clean:
	@echo "opencode:"
	@for item in $(OPENCODE); do \
		dst=$${item##*:}; link="$(OPENCODE_DIR)/$$dst"; \
		if [ -L "$$link" ]; then \
			printf "  %-20s \033[34m[rm]\033[0m\n" "$$dst"; \
			rm "$$link"; \
		else \
			printf "  %-20s \033[90m[--]\033[0m\n" "$$dst"; \
		fi; \
	done
	@echo ".agents:"
	@for skill in $(REPO_DIR)/.agents/skills/*/; do \
		[ -d "$$skill" ] || continue; \
		name=$$(basename "$$skill"); \
		link="$(OPENCODE_DIR)/skills/$$name"; \
		if [ -L "$$link" ]; then \
			printf "  %-20s \033[34m[rm]\033[0m\n" "$$name"; \
			rm "$$link"; \
		else \
			printf "  %-20s \033[90m[--]\033[0m\n" "$$name"; \
		fi; \
	done
