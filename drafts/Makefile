OUT_DIR=/Users/chl/org/.export
OUT_FILES=$(patsubst %.org,$(OUT_DIR)/%.pdf,$(wildcard *.org))

.PHONY: all clean veryclean dist

all: dist

dist: $(OUT_DIR) $(OUT_FILES)

$(OUT_DIR):
	mkdir -v -p $(OUT_DIR)

%.pdf: %.org
	emacs --batch -l setup.el --eval '(progn (find-file "$<") (org-latex-export-to-pdf))'

$(OUT_DIR)/%.pdf: %.pdf
	mv $< $(OUT_DIR)

clean:
	rm *.{bbl,tex}

veryclean:
	rm dist/*.pdf dist/fig-*.png
