#! /usr/bin/env sh

#
# Process R Markdown file and display HTML output directly in the browser.
#

usage()
{
cat << EOF
Usage: $0 [-h] [-c] [-b] [-t] filename

This script weaves and tangles an R Markdown file using knitr.

OPTIONS:
   -h      show this message
   -c      compile Rmd file to Markdown and HTML
   -b      compile Rmd file and display HTML file in browser
   -t      tangle Rmd file
EOF
}

while getopts ":hcbt" o; do
    case $o in
	h)
	    usage
	    exit 1
	    ;;
	c)
	    compile=1
	    ;;
	b) 
	    browser=1
	    ;;
	t)    
	    tangle=1
	    ;;
	*)
	    usage
	    ;;
    esac
done
shift $((OPTIND-1))

if [ -r "$1" ]; then
    mdfile="$1"
    mdfile="${mdfile%.*}"  # remove extension
    if [[ $compile = 1 ]]; then
	(
	    Rscript -e "require(knitr); require(markdown); knit('${mdfile}.rmd', quiet=TRUE); \
                        markdownToHTML('${mdfile}.md', '${mdfile}.html')"
	) > /dev/null 2>&1
    fi
    if [[ $browser = 1 ]]; then
	(
	    Rscript -e "require(knitr); require(markdown); knit('${mdfile}.rmd', quiet=TRUE); \
                        markdownToHTML('${mdfile}.md', '${mdfile}.html'); browseURL('${mdfile}.html')"
	) > /dev/null 2>&1
    fi
    if [[ $tangle = 1 ]]; then
	(
	    Rscript -e "require(knitr); purl('${mdfile}.rmd')"
	) > /dev/null 2>&1
    fi	
else
    exit 0
fi