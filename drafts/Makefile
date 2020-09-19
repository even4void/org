# Time-stamp: <2020-09-19 19:00:33 chl>
#
# General purpose Makefile to compile all documents in my Org directory.
#
# Requires: (in current working directory)
# - 'eval.el':    Org stuff for first PDF target
# - 'macros.tex': TeX stuff for second PDF target
#
# NOTE: Don't remove plain TeX files since we also store some files there.
.PHONY: all clean veryclean

all: pdf

%.pdf: %.org
	emacs --batch -l setup.el --eval '(progn (find-file "$<") (org-latex-export-to-pdf))'
	mv $*.tex $*.tex~  # keep a copy in case we need it

%.pdf: %.tex
	latexmk -pdflatex=luatex -pdf $<

clean:
	latexmk -c
	-rm *.tex~
	rm *.{bbl,synctex.gz}

veryclean:
	latexmk -C
	-rm *.tex~
	-rm *.{bbl,synctex.gz}
	rm *.pdf
