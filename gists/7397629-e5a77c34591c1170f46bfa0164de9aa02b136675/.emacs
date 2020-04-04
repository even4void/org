(require 'offlineimap)
(add-to-list 'load-path "~/.emacs.d/lib/mu4e")
(require 'mu4e)
(require 'mu4e-maildirs-extension)
(mu4e-maildirs-extension)

(setq mu4e-drafts-folder "/drafts"
      mu4e-sent-folder   "/sent"
      mu4e-trash-folder  "/trash")
(setq mu4e-maildir-shortcuts
      '(("/INBOX"             . ?i)
	("/sent"              . ?s)
	("/trash"             . ?t)
	("/drafts"            . ?d)
	("/review"            . ?r)
	("/cours"             . ?c)
	("/private"           . ?p)
	("/inserm"            . ?m)
	("/aphp"              . ?a)
	("/mailing"           . ?l)))
(add-to-list 'mu4e-bookmarks '("flag:attach"    "Messages with attachment"   ?a) t)
(add-to-list 'mu4e-bookmarks '("size:5M..500M"  "Big messages"               ?b) t)
(add-to-list 'mu4e-bookmarks '("flag:flagged"   "Flagged messages"           ?f) t)

(setq mu4e-headers-date-format "%Y-%m-%d %H:%M:%S"
      mu4e-headers-fields '((:date . 20)
			    (:flags . 5)
			    (:mailing-list . 10)
			    (:from-or-to . 25)
			    (:subject . nil))) 

(setq mu4e-reply-to-address "xxxxxxxxxx"
      user-mail-address "xxxxxxxxxx"
      user-full-name "xxxxxxxxxx"
      message-signature "xxxxxxxxxx"
      message-citation-line-format "On %Y-%m-%d %H:%M:%S, %f wrote:"
      message-citation-line-function 'message-insert-formatted-citation-line
      mu4e-headers-results-limit 250)

(require 'smtpmail)

(setq message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials
      '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials
      (expand-file-name "~/.authinfo.gpg")
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-debug-info t)

(setq message-kill-buffer-on-exit t
      mu4e-sent-messages-behavior 'delete
      mu4e-headers-skip-duplicates t
      mu4e-headers-include-related t
      mail-user-agent 'mu4e-user-agent
      mu4e-get-mail-command "offlineimap"
      mu4e-attachment-dir  "~/Downloads"
      smtpmail-queue-mail  nil
      smtpmail-queue-dir   "~/Maildir/queue/cur")