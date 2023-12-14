
TWELF := twelf-server
MERCURY := mmc
SWIPL := swipl
BQN := BQN
FORTRAN := gfortran
UIUA := uiua
SMALLTALK := gst

BUILDDIR := _build

.PHONY: all clean day1 day2 day3 day4 day9 day11
.PHONY: skel-prolog skel-bqn skel-uiua
.DEFAULT: all

all: day2 day4 day9

## Day 1: Twelf
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

## Day 3: BQN
day3: $(BUILDDIR)/has-bqn
	@echo "== Day 3 =="
	@$(BQN) -f day3/day3.bqn $(CURDIR)/day3/input.txt
	@echo

## Day 4: POSIX sh
day4:
	@echo "== Day 4 =="
	@$(SHELL) day4/day4.sh $(CURDIR)/day4/input.txt
	@echo

## Day 9: FORTRAN
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
	@$(SMALLTALK) -q -f $< day11/input.txt

### Skeletons

## Prolog skeleton
skel-prolog: skel-prolog/skel.pl $(BUILDDIR)/has-prolog
	$(SWIPL) $< skel-prolog/input.txt

## BQN skeleton
skel-bqn: skel-bqn/skel.bqn $(BUILDDIR)/has-bqn
	$(BQN) -f $< $(CURDIR)/skel-bqn/input.txt

## Uiua skeleton (TODO)
skel-uiua: skel-uiua/skel.ua $(BUILDDIR)/has-uiua
	$(UIUA) $< skel-uiua/input.txt

## Bash skeleton
skel-bash: skel-bash/skel.sh $(BUILDDIR)/has-bash
	$(BASH) $< $(CURDIR)/skel-bash/input.txt

## TODO:
## ALGOL-60 skeleton
## APL skeleton
## Ada skeleton
## Bash skeleton
## COBOL skeleton
## Epigram skeleton
## Mizar skeleton
## Pascal skeleton
## Smalltalk skeleton
## Piet skeleton

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

clean::
	$(RM) $(BUILDDIR)/has-twelf
	$(RM) $(BUILDDIR)/has-mercury
	$(RM) $(BUILDDIR)/has-prolog
	$(RM) $(BUILDDIR)/has-bqn
	$(RM) $(BUILDDIR)/has-uiua
	$(RM) $(BUILDDIR)/has-fortran
	$(RM) $(BUILDDIR)/has-smalltalk
	$(RM) -d $(BUILDDIR)
