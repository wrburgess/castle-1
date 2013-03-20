;(add-to-list 'load-path (concat dotfiles-dir "vendor/auto-complete"))
(require 'auto-complete)
(require 'auto-complete-config)

(ac-config-default)

;(ac-flyspell-workaround)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/auto-complete/dict")

;(setq ac-comphist-file (concat dotfiles-tmp-dir "ac-comphist.dat"))

(global-auto-complete-mode t)
(setq ac-auto-show-menu t)
(setq ac-dwim t)
(setq ac-use-menu-map t)
(setq ac-quick-help-delay 1)
(setq ac-quick-help-height 60)

(setq-default ac-sources
             '(ac-source-yasnippet
               ac-source-dictionary
               ac-source-abbrev
               ac-source-words-in-all-buffer))

;;ac-source-css-property
(dolist (mode '(magit-log-edit-mode log-edit-mode org-mode text-mode haml-mode
                sass-mode yaml-mode csv-mode espresso-mode haskell-mode
                html-mode nxml-mode sh-mode smarty-mode clojure-mode
                lisp-mode textile-mode markdown-mode tuareg-mode scss-mode))
  (add-to-list 'ac-modes mode))

(add-hook 'elisp-mode (lambda () add-to-list 'ac-sources '(ac-source-symbols ac-source-functions)))

;(require 'ac-slime)
;(add-hook 'slime-mode-hook 'set-up-slime-ac)
;(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)


;;Key triggers
(ac-set-trigger-key "TAB")
;(define-key ac-completing-map (kbd "C-N") 'ac-next)
;(define-key ac-completing-map (kbd "C-P") 'ac-previous)
(define-key ac-completing-map "\t" 'ac-complete)
(define-key ac-completing-map "\r" 'ac-complete)
