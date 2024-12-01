
AOC_URL := https://adventofcode.com/2024
BUILDDIR := _build
CURL := curl
NIX := nix

day1: $(BUILDDIR)/day1-input.txt
	$(NIX) run ".#day1" $(BUILDDIR)/day1-input.txt

define PROBLEM_INPUT
$(BUILDDIR)/day$(1)-input.txt: | $(BUILDDIR) $(BUILDDIR)/cookie.txt
	$(CURL) $(AOC_URL)/day/$(1)/input --cookie $(BUILDDIR)/cookie.txt --output $$@
endef

$(eval $(call PROBLEM_INPUT,1))

$(BUILDDIR)/cookie.txt:
	@if ! [ -e "$@" ]; then                                                                  \
		echo "Populate the cookie file from your browser";                                   \
		echo "Should look something like:";                                                  \
		echo;                                                                                \
		echo "Set-Cookie: session=<session-id>; Domain=.adventofcode.com; Secure; HttpOnly"; \
		exit 1;                                                                              \
	fi

$(BUILDDIR):
	mkdir -p $(BUILDDIR)
