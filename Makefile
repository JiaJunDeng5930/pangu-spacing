EMACS ?= emacs
BATCH := $(EMACS) $(EFLAGS) -batch -q -no-site-file -L .

all: pangu-spacing.elc

README.md: make-readme-markdown.el
	emacs --script $< <pangu-spacing.el>$@ 2>/dev/null
	sed -i '1s%^%<a href="https://github.com/coldnew/pangu-spacing.el"><img src="https://www.gnu.org/software/emacs/images/emacs.png" alt="Normalize Logo" width="80" height="80" align="right"></a> \n%' $@

make-readme-markdown.el:
	wget -q -O $@ https://raw.github.com/mgalgs/make-readme-markdown/master/make-readme-markdown.el
.INTERMEDIATE: make-readme-markdown.el

clean:
	$(RM) *.elc

%.elc: %.el
	$(BATCH) --eval '(byte-compile-file "$<")'

test:
	$(BATCH) -L . -l test/pangu-spacing-test.el -f ert-run-tests-batch-and-exit

.PHONY: check clean test README.md
