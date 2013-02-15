;; Here's my fucking package bitch
(require 'twittering-mode)
(require 'powerline)

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "cd %s; ctags -a -e -f TAGS --tag-relative -R app lib" dir-name)))

(defun switch-to-previous-buffer ()
  "toggle between this and previous buffer"
  (interactive)
  (switch-to-buffer (other-buffer)))

(defun set-font-size (font-height)
  (custom-set-faces `(default ((t (:height ,font-height :family "Monaco"))))))

(defun set-font-retina ()
  "Set the font size for laptop screen"
  (interactive)
  (set-font-size 113))

(defun set-font-cinema ()
  "Set font size for the cinema display"
  (interactive)
  (set-font-size 170))

(defun current-itunes-song ()
  "Show the currently playing song in iTunes in the mode-line"
  (interactive)
  (do-applescript
   "tell application \"iTunes\"
           set currentTrack to the current track
           set artist_name to the artist of currentTrack
           set song_title to the name of currentTrack
           return artist_name & \" - \" & song_title
        end tell"))

(defun ep ()
  "Open ~/.emacs.d/personal/personal.el in current buffer"
  (interactive)
  (find-file "~/.emacs.d/personal/personal.el"))

(defun active-modes ()
  "Give a message of which minor modes are enabled in the current buffer."
  (interactive)
  (let ((all-active-modes))
    (mapc (lambda (mode) (condition-case nil
                             (if (and (symbolp mode) (symbol-value mode))
                                 (add-to-list 'all-active-modes mode))
                           (error nil) ))
          minor-mode-list)
    (message "Active modes are %s" all-active-modes)))

(defun toggle-transparency ()
  "Toggle window trasnsparency"
  (interactive)
  (if (/=
       (or (cadr (frame-parameter nil 'alpha)) 100)
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(85 50))))

(defun launch-hashrocket-for-the-lord ()
  "Insert hash rockets in one key"
  (interactive)
  (insert "=>"))

(require 'rspec-mode)
;;rspec fuckery
(defun rspec-runner ()
  "Returns command line to run rspec"
  (let ((bundle-command (if (rspec-bundle-p) "source \"/Users/daytonn/.bash_profile\"; auto_gemsets; bundle exec " ""))
        (zeus-command (if (rspec-zeus-p) "zeus " "")))
    (concat bundle-command zeus-command (if rspec-use-rake-flag
                                            (concat rspec-rake-command " spec")
                                          rspec-spec-command))))

(setq mode-require-final-newline nil)
;; JS2
(custom-set-variables
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p nil)
 )

;; Captain hooks
(add-hook 'before-save-hook 'whitespace-cleanup nil t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Snippets
(setq yas-snippet-dirs '("~/.emacs.d/personal/snippets/"))
(add-hook 'snippet-mode (lambda () (setq require-final-newline nil)))
;; POWERLINE
(powerline-default)

;; Smexy
(smex-initialize)
(smex-auto-update 30)
(setq smex-show-unbound-commands t)
(global-set-key (kbd "M-x") 'smex)

;; Environment
(setq exec-path (cons "/usr/local/bin" exec-path))
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(getenv "GEM_HOME")

;; Editor settings
(setq ispell-dictionary "en")
(setq default-tab-width 2)
(setq prelude-guru nil)
(global-linum-mode 1)
(set-default 'cursor-type 'bar)
(blink-cursor-mode t)
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.jst" . html-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq prelude-whitespace nil)
(setq linum-format " %d ")

;; Thanks but no thanks Joe, I can manage to match parens myself
(setq paredit-mode nil)

;; Focus buffers
(global-set-key [S-left] 'windmove-left)
(global-set-key [S-right] 'windmove-right)
(global-set-key [S-up] 'windmove-up)
(global-set-key [S-down] 'windmove-down)
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)
;; Transpose buffers
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<f5>")  'sort-lines)

;; Hotkeys
(global-set-key (kbd "C-\\")  'switch-to-previous-buffer)
(global-set-key (kbd "s-a")  'mark-page)
(global-set-key (kbd "s-q")  'save-buffers-kill-terminal)
(global-set-key (kbd "s-V")  'split-window-right)
(global-set-key (kbd "s-H")  'split-window-below)
(global-set-key (kbd "s-F")  'ack)
(global-set-key (kbd "s-f")  'occur)
(global-set-key (kbd "M-t")  'projectile-find-file)
(global-set-key (kbd "s-w")  'delete-window)
(global-set-key (kbd "s-o")  'ido-find-file)
(global-set-key (kbd "s-c")  'kill-ring-save)
(global-set-key (kbd "s-v")  'yank)
(global-set-key (kbd "s-D")  'prelude-duplicate-current-line-or-region)
(global-set-key (kbd "s-e")  'eval-buffer)
(global-set-key (kbd "s-z")  'undo)
(global-set-key (kbd "s-u") 'toggle-transparency)
(global-set-key (kbd "s-l") 'launch-hashrocket-for-the-lord)
(global-set-key (kbd "s-=") 'launch-hashrocket-for-the-lord)
(global-set-key (kbd "s-.") 'shell)

;; rinari-mode
(global-set-key (kbd "s-C") 'rinari-find-controller)
(global-set-key (kbd "s-M") 'rinari-find-model)
(global-set-key (kbd "<C-S-s-v>") 'rinari-find-view)
(global-set-key (kbd "s-S") 'rspec-toggle-spec-and-target)
(global-set-key (kbd "<S-s-RET>") 'rinari-find-migration)
(global-set-key (kbd "C-S-s-c") 'rinari-find-configuration)
(global-set-key (kbd "s-t")  'rinari-find-file-in-project)
(global-set-key (kbd "s-R")  'rspec-verify)
(global-set-key (kbd "s-r")  'rspec-verify-single)
(global-set-key (kbd "C-s-r")  'rspec-verify-all)

(setq rinari-tags-file-name "TAGS")
;; HOME
(cd "~/Development")
(set-font-cinema)
(set-fringe-mode 0)
(scroll-bar-mode -1)
(disable-theme 'zenburn)
(load-theme 'neopolitan t)
