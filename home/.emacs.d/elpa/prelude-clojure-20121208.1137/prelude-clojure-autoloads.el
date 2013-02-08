;;; prelude-clojure-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "prelude-clojure" "prelude-clojure.el" (20746
;;;;;;  40567))
;;; Generated autoloads from prelude-clojure.el

(require 'prelude-lisp)

(eval-after-load 'clojure-mode '(progn (defun prelude-clojure-mode-defaults nil (subword-mode 1) (run-hooks 'prelude-lisp-coding-hook)) (setq prelude-clojure-mode-hook 'prelude-clojure-mode-defaults) (add-hook 'clojure-mode-hook (lambda nil (run-hooks 'prelude-clojure-mode-hook)))))

(eval-after-load 'nrepl '(progn (add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode) (defun prelude-nrepl-mode-defaults nil (subword-mode 1) (run-hooks 'prelude-interactive-lisp-coding-hook)) (setq prelude-nrepl-mode-hook 'prelude-nrepl-mode-defaults) (add-hook 'nrepl-mode-hook (lambda nil (run-hooks 'prelude-nrepl-mode-hook)))))

;;;***

;;;### (autoloads nil nil ("prelude-clojure-pkg.el") (20746 40567
;;;;;;  368982))

;;;***

(provide 'prelude-clojure-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; prelude-clojure-autoloads.el ends here
