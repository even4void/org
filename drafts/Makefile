# Time-stamp: <2020-08-25 08:43:30 chl>
#
# General purpose Makefile to compile all documents in my Org directory.
#
# Requires: (in current working directory)
# - 'eval.el':    Org stuff for first PDF target
# - 'macros.tex': TeX stuff for second PDF target
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