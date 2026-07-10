PYTHON_DIR := python
SCRIPT     := quasicrystal_hamiltonian.py
OUTPUT     := ab_hamiltonian_rainbow_wide_glow.svg

.PHONY: help all install build run clean

.DEFAULT_GOAL := help

## help: list the available targets
help:
	@echo "Available targets:"
	@grep -E '^## [a-z]+:' $(MAKEFILE_LIST) | sed 's/^## /  /'

all: run

## install: create the virtualenv and install pinned dependencies
install:
	cd $(PYTHON_DIR) && pipenv install

## build: alias for install (sets up everything needed to run)
build: install

## run: generate the SVG artwork (install first if needed)
run: install
	cd $(PYTHON_DIR) && pipenv run python $(SCRIPT)

## clean: remove generated output
clean:
	rm -f $(PYTHON_DIR)/$(OUTPUT) $(OUTPUT)
