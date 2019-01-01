# If ENV is pipenv, run export PIPENV_VENV_IN_PROJECT=1
# Otherwise, .venv will not be in the current project.

IPYNB_FILES = $(wildcard *.ipynb)
REPORTS = $(patsubst %.ipynb, reports/%.html, $(IPYNB_FILES))
SCRIPTS = $(patsubst %.ipynb, scripts/%.py, $(IPYNB_FILES))
EXECUTED = $(patsubst %.ipynb, executed/%_executed.ipynb, $(IPYNB_FILES))

all: $(REPORTS) $(SCRIPTS) $(EXECUTED)
reports: $(REPORTS)
scripts: $(SCRIPTS)
executed: $(EXECUTED)

reports/%.html: %.ipynb
	jupyter nbconvert $< --output $@

scripts/%.py: %.ipynb
	jupyter nbconvert --to python $< --output $@

executed/%_executed.ipynb: %.ipynb
	papermill -k python3 $< $@

.PHONY: all reports scripts executed
