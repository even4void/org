RMDFILE=demo-rmd-pandoc
PANDOC=~/.cabal/bin/pandoc

all:
	Rscript -e "require(knitr); require(markdown); knit('$(RMDFILE).rmd', '$(RMDFILE).md'); purl('$(RMDFILE).rmd')"
	${PANDOC} --mathjax --toc -B header.html -A footer.html --bibliography refs.bib --css markdown.css -s $(RMDFILE).md -o $(RMDFILE).html
 