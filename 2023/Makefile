
TWELF := twelf-server
MERCURY := mmc
BUILDDIR := _build

.PHONY: day1 day2 clean

## Day 1: Twelf
day1: day1/day1.log
	grep --text part.-answer $^

day1/day1.log: $(BUILDDIR)/has-twelf
	echo "make day1/sources.cfg" | $(TWELF) > $@

clean::
	$(RM) day1/day1.log

## Day 2: Mercury
day2: day2/day2
	./day2/day2 day2/input.txt

day2/day2: $(BUILDDIR)/has-mercury
	cd day2 && $(MERCURY) --make day2

clean::
	$(RM) day2/day2 day2/day2.err day2/day2.mh
	$(RM) -r day2/Mercury

$(BUILDDIR):
	mkdir -p $@

$(BUILDDIR)/has-mercury: | $(BUILDDIR)
	$(MERCURY) --version
	touch $@

clean::
	$(RM) $(BUILDDIR)/has-mercury

$(BUILDDIR)/has-twelf: | $(BUILDDIR)
	$(TWELF) < /dev/null
	touch $@

clean::
	$(RM) $(BUILDDIR)/has-twelf
