(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.rmd\\'" . markdown-mode))
(add-hook 'markdown-mode-hook 'turn-on-outline-minor-mode)

(defun rmarkdown-new-chunk (name)
  "Insert a new R chunk."
  (interactive "sChunk name: ")
  (insert "\n```{r " name "}\n")
  (save-excursion
    (newline)
    (insert "```\n")
    (previous-line)))

(defun rmarkdown-weave-file ()
  "Run knitr on the current file and weave it as MD and HTML."
  (interactive)
  (shell-command 
   (format "knit.sh -c %s" 
       (shell-quote-argument (buffer-file-name)))))

(defun rmarkdown-tangle-file ()
  "Run knitr on the current file and tangle its R code."
  (interactive)
  (shell-command 
   (format "knit.sh -t %s" 
       (shell-quote-argument (buffer-file-name)))))

(defun rmarkdown-preview-file ()
  "Run knitr on the current file and display output in a browser."
  (interactive)
  (shell-command 
   (format "knit.sh -b %s" 
       (shell-quote-argument (buffer-file-name)))))