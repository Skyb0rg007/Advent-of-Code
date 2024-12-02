
CURL := curl
NIX := nix

BUILDDIR := _build
AOC_URL := https://adventofcode.com/2024
DAYS := 1 2

define RULES_FOR_DAY
.PHONY: day$(1)

day$(1): $(BUILDDIR)/day$(1)-input.txt
	$(NIX) run ".#day$(1)" $(BUILDDIR)/day$(1)-input.txt

$(BUILDDIR)/day$(1)-input.txt: | $(BUILDDIR) $(BUILDDIR)/cookie.txt
	$(CURL) $(AOC_URL)/day/$(1)/input --cookie $(BUILDDIR)/cookie.txt --output $$@

distclean::
	$(RM) $(BUILDDIR)/day$(1)-input.txt
endef

$(foreach day,$(DAYS),$(eval $(call RULES_FOR_DAY,$(day))))

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
