
AOC_URL := https://adventofcode.com/2024
DOWNLOAD = curl $(AOC_URL)/day/$(1)/input --output $(2)
BUILDDIR := _build
NIX := nix

day1: $(BUILDDIR)/day1-input.txt
	$(NIX) run ".#day1" $(BUILDDIR)/day1-input.txt

$(BUILDDIR)/cookie.txt:
	@if ! [ -e $@ ]; then \
		echo "Populate the cookie file from your browser"; \
		exit 1; \
	fi

$(BUILDDIR)/day1-input.txt: | $(BUILDDIR) $(BUILDDIR)/cookie.txt
	curl $(AOC_URL)/day/1/input --cookie $(BUILDDIR)/cookie.txt --output $@

$(BUILDDIR):
	mkdir -p $(BUILDDIR)
