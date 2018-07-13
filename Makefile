# Makefile for generating R packages.
# 2011 Andrew Redd
#
# Assumes Makefile is in a folder where package contents are in a subfolder pkg.
# Roxygen uses the roxygen2 package, and will run automatically on check and all.

PKG_VERSION=$(shell grep -i ^version pkg/DESCRIPTION | cut -d : -d \  -f 2)
PKG_NAME=$(shell grep -i ^package pkg/DESCRIPTION | cut -d : -d \  -f 2)

PY_INCLUDE_DIR=include
PY_PARSER=include/pdfparse.py

ifeq ($(OS),Windows_NT)
    PARSER_EXE := pdfparse.exe
else
    PARSER_EXE := pdfparse
endif

R_FILES := $(wildcard pkg/R/*.R)
SRC_FILES := $(wildcard pkg/src/*) $(addprefix pkg/src/, $(COPY_SRC))
PKG_FILES := pkg/DESCRIPTION pkg/NAMESPACE $(R_FILES) $(SRC_FILES)

py_freeze: $(PY_PARSER) $(PY_INCLUDE_DIR)
		pip install --upgrade pandas PyPDF2 pyinstaller
		pyinstaller --onefile $(PY_PARSER) --distpath $(PY_INCLUDE_DIR)

		cp include/$(PARSER_EXE) pkg/inst/$(PARSER_EXE)

$(PKG_NAME)_$(PKG_VERSION).tar.gz: $(PKG_FILES)
		R CMD build pkg

check: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R CMD check $(PKG_NAME)_$(PKG_VERSION).tar.gz

install: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R CMD INSTALL $(PKG_NAME)_$(PKG_VERSION).tar.gz

clean:
	-rm -f $(PKG_NAME)_*.tar.gz
	-rm -r -f $(PKG_NAME).Rcheck
	-rm -r -f include/build
	-rm -r -f include/__pycache__
	-rm -r -f include/*.spec
	-rm -r -f include/*.pyc

all: py_freeze check install clean
