;;; org-babel.el --- default settings for org->pdf compilation
;;;
;;; Commentary:
;;; This is very basic stuff.
;;;
;;; Code:
(require 'org)

(setq org-bibtex-file "/home/chl/org/references.bib"
      org-export-with-author nil
      org-export-with-creator nil
      org-export-with-toc nil
      org-export-with-section-numbers nil
      org-html-postamble nil
      org-html-htmlize-output-type nil
      org-html-doctype "xhtml5"
      org-latex-default-class "tufte-handout"
      org-latex-pdf-process '("latexmk -pdf -bibtex-cond -f -outdir=%o %f"))

(eval-after-load "ox-latex"
  '(add-to-list 'org-latex-classes
                '("tufte-handout"
                  "\\documentclass[nobib]{tufte-handout}
                   \\usepackage[backend=bibtex,style=numeric-comp,citestyle=numeric-comp,autocite=plain]{biblatex}
                   \\addbibresource{/home/chl/org/references.bib}
                   \\usepackage{booktabs}
                   % little HACK for tabular only environment
                   \\setlength{\\doublerulesep}{\\arrayrulewidth}
                   \\let\\tbl\\tabular
                   \\def\\tabular{\\sffamily\\small\\tbl}
                   \\usepackage{graphicx}
                   \\usepackage{microtype}
                   \\usepackage{hyphenat}
                   \\usepackage{marginfix}
                   \\usepackage{amsmath}
                   \\usepackage{morefloats}
                   \\usepackage{fancyvrb}
                   \\fvset{fontsize=\\normalsize}
                   \\usepackage{xspace}
                   \\usepackage{nicefrac}
                   \\usepackage{units}
                   \\usepackage{soul}
                   \\usepackage{xcolor}
                   \\usepackage{hyperref}
                   \\hypersetup{colorlinks,allcolors=darkgray}
                   \\makeatletter
                   \\patchcmd{\\hyper@link@}
                     {{\\Hy@tempb}{#4}}
                     {{\\Hy@tempb}{\\ul{#4}}}
                     {}{}
                   \\makeatother
                   [NO-DEFAULT-PACKAGES]
                   [EXTRA]"
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                  ("\\paragraph{%s}" . "\\paragraph*{%s}")
                  ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))


(eval-after-load "ox-latex"
  '(add-to-list 'org-latex-packages-alist
                '("AUTO" "babel" t ("pdflatex"))))
(eval-after-load "ox-latex"
  '(add-to-list 'org-latex-packages-alist
                '("AUTO" "polyglossia" t ("xelatex" "lualatex"))))
(eval-after-load "ox-latex"
  '(add-to-list 'org-latex-packages-alist '("autostyle=true" "csquotes")))
