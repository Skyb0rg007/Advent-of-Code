
TWELF := twelf-server
MERCURY := mmc
SWIPL := swipl
BQN := BQN
FORTRAN := gfortran
UIUA := uiua
SMALLTALK := gst
GNATMAKE := gnatmake

BUILDDIR := _build

.PHONY: all clean
.PHONY: day1  day2  day3  day4  day5  day6  day7  day8  day9  day10
.PHONY: day11 day12 day13 day14 day15 day16 day17 day18 day19 day20
.PHONY: day21 day22 day23 day24 day25
.DEFAULT: all

all: day2 day4 day11 day12 day13

## Day 1: Twelf (TODO)
day1: day1/day1.log
	@echo "== Day 1 =="
	@grep --text part.-answer $^
	@echo

day1/day1.log: $(BUILDDIR)/has-twelf
	echo "make day1/sources.cfg" | $(TWELF) > $@

clean::
	$(RM) day1/day1.log

## Day 2: Mercury
day2: day2/day2
	@echo "== Day 2 =="
	@./day2/day2 day2/input.txt
	@echo

day2/day2: $(BUILDDIR)/has-mercury
	cd day2 && $(MERCURY) --make day2

clean::
	$(RM) day2/day2 day2/day2.err day2/day2.mh
	$(RM) -r day2/Mercury

## Day 3: BQN (TODO)
day3: $(BUILDDIR)/has-bqn
	@echo "== Day 3 =="
	@$(BQN) -f day3/day3.bqn $(CURDIR)/day3/input.txt
	@echo

## Day 4: POSIX sh
day4:
	@echo "== Day 4 =="
	@$(SHELL) day4/day4.sh $(CURDIR)/day4/input.txt
	@echo

## Day 9: FORTRAN (TODO)
$(BUILDDIR)/day9: day9/day9.f90 $(BUILDDIR)/has-fortran
	$(FORTRAN) $< -o $@

day9: $(BUILDDIR)/day9
	@echo "== Day 9 =="
	@exec $(BUILDDIR)/day9 day9/test-input.txt
	@echo

clean::
	$(RM) $(BUILDDIR)/day9

## Day 11: Smalltalk
day11: day11/day11.st $(BUILDDIR)/has-smalltalk
	@echo "== Day 11 =="
	@$(SMALLTALK) -q -f $< day11/input.txt
	@echo

## Day 12: Prolog
day12: day12/day12.pl $(BUILDDIR)/has-prolog
	@echo "== Day 12 =="
	@$(SWIPL) $< day12/input.txt
	@echo

## Day 13: Ada
day13: $(BUILDDIR)/day13
	@echo "== Day 13 =="
	@exec $(BUILDDIR)/day13 day13/input.txt
	@echo

$(BUILDDIR)/day13: day13/day13.adb $(BUILDDIR)/has-ada
	$(GNATMAKE) day13/day13 -o $@ -D $(BUILDDIR)

clean::
	$(RM) $(BUILDDIR)/day13 $(BUILDDIR)/day13.o $(BUILDDIR)/day13.ali

##############################################################################

$(BUILDDIR):
	mkdir -p $@

$(BUILDDIR)/has-twelf: | $(BUILDDIR)
	$(TWELF) < /dev/null
	touch $@

$(BUILDDIR)/has-mercury: | $(BUILDDIR)
	$(MERCURY) --version
	touch $@

$(BUILDDIR)/has-prolog: | $(BUILDDIR)
	$(SWIPL) --version
	touch $@

$(BUILDDIR)/has-bqn: | $(BUILDDIR)
	$(BQN) --help
	touch $@

$(BUILDDIR)/has-uiua: | $(BUILDDIR)
	$(UIUA) --version
	touch $@

$(BUILDDIR)/has-fortran: | $(BUILDDIR)
	$(FORTRAN) --version
	touch $@

$(BUILDDIR)/has-smalltalk: | $(BUILDDIR)
	$(GST) --version
	touch $@

$(BUILDDIR)/has-ada: | $(BUILDDIR)
	$(GNATMAKE) --version
	touch $@

clean::
	$(RM) $(BUILDDIR)/has-twelf
	$(RM) $(BUILDDIR)/has-mercury
	$(RM) $(BUILDDIR)/has-prolog
	$(RM) $(BUILDDIR)/has-bqn
	$(RM) $(BUILDDIR)/has-uiua
	$(RM) $(BUILDDIR)/has-fortran
	$(RM) $(BUILDDIR)/has-smalltalk
	$(RM) $(BUILDDIR)/has-ada
	$(RM) -d $(BUILDDIR)
