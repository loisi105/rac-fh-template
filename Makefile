# Build every meeting folder (folders starting with a date) with latexmk
DIRS := $(wildcard 20*)

all:
	@for d in $(DIRS); do (cd $$d && latexmk -pdf -interaction=nonstopmode meeting.tex) || exit 1; done

clean:
	@for d in $(DIRS); do (cd $$d && latexmk -C); done

.PHONY: all clean
