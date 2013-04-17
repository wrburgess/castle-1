;;; magithub-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (magithub-clone) "magithub" "../../../../../../../.emacs.d/elpa/magithub-20121130.1740/magithub.el"
;;;;;;  "da485cc61f0a4194d3ec9f7dbcfd89b7")
;;; Generated autoloads from ../../../../../../../.emacs.d/elpa/magithub-20121130.1740/magithub.el

(autoload 'magithub-clone "magithub" "\
Clone GitHub repo USERNAME/REPO into directory DIR.
If SSHP is non-nil, clone it using the SSH URL.  Once the repo is
cloned, switch to a `magit-status' buffer for it.

Interactively, prompts for the repo name and directory.  With a
prefix arg, clone using SSH.

\(fn USERNAME REPO DIR &optional SSHP)" t nil)

(eval-after-load 'magit '(unless (featurep 'magithub) (require 'magithub)))

;;;***

;;;### (autoloads nil nil ("../../../../../../../.emacs.d/elpa/magithub-20121130.1740/magithub-pkg.el"
;;;;;;  "../../../../../../../.emacs.d/elpa/magithub-20121130.1740/magithub.el")
;;;;;;  (20812 36014 960858 0))

;;;***

(provide 'magithub-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; magithub-autoloads.el ends here
