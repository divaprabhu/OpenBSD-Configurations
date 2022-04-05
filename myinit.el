(setq user-emacs-directory (expand-file-name "~/.cache/emacs/"))

(setq inhibit-startup-screen t)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq next-line-add-newline t)

(line-number-mode)
(column-number-mode)
(size-indication-mode)
(setq what-cursor-show-names t)

(setq resize-mini-windows t)

(setq enable-recursive-minibuffer t)
(setq minibuffer-depth-indicate-mode t)

(setq minibuffer-eldef-shorten-default t)

(setq history-length 100)
(setq history-delete-duplicates t)

(setq isearch-resume-in-command-history t)

(setq suggest-key-bindings 5)
(setq extended-command-suggest-shorter t)

(setq highlight-nonselected-windows t)

(setq mark-even-if-inactive nil)

(setq set-mark-command-repeat-pop t)

(defun kill-region-or-backward-word ()
   (interactive)
   (if (region-active-p)
       (kill-region (region-beginning) (region-end))
     (backward-kill-word 1)))
(global-set-key (kbd "C-w") 'kill-region-or-backward-word)

(setq kill-do-not-save-duplicates t)

(setq save-interprogram-paste-before-kill t)

(setq bookmark-save-flag 1)

(setq scroll-conservatively 2)

(setq hscroll-step 2)

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

(setq hi-lock-auto-select-face t)

(setq-default indicate-empty-lines t)

(line-number-mode)
(column-number-mode)
(size-indication-mode)
(setq what-cursor-show-names t)

(setq line-number-display-limit nil)

(setq blink-cursor-blink -1)

(setq-default display-line-numbers 'relative)
(setq-default display-line-numbers-width 4)
(setq display-raw-bytes-as-hex t)
(setq visible-bell t)

(setq isearch-lazy-count t)

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(setq make-backup-files nil)
(setq backup-directory-alist `(("." . ,(expand-file-name "backups/" user-emacs-directory))))

(global-auto-revert-mode t)

(make-directory (expand-file-name "autosave/" user-emacs-directory) t)
(setq auto-save-list-file-prefix (expand-file-name "autosave/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "autosave/" user-emacs-directory) t)))

(setq delete-by-moving-to-trash t)

(setq help-window-select t)
(add-hook 'occur-hook
     '(lambda ()
	(switch-to-buffer-other-window "*Occur*")))
(global-set-key (kbd "C-x C-b") 'buffer-menu-other-window)
(add-hook 'compilation-finish-functions 'switch-to-buffer-other-window 'compilation)
(customize-set-variable
 'display-buffer-alist
 '(("\\*\\(Completions\\|Metahelp\\|Help\\|shell\\|Apropos\\|Occur\\|Messages\\|Org Select\\|vc-diff\\).*"
    (display-buffer-in-side-window)
    (side . bottom)
    (slot . 0)
    (window-height . 0.5))
   ("\\*\\(info\\|compilation\\|eshell\\).*"
    (display-buffer-in-side-window)
    (direction . bottom)
    (slot . 0))))

(scroll-bar-mode -1)

(menu-bar-mode -1)

(tool-bar-mode -1)

(setq tab-bar-show 1)

(setq use-dialog-box nil)

(setq tab-always-indent 'complete)

(add-hook 'text-mode-hook 'turn-on-auto-fill)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(setq imenu-auto-rescan t)

(which-function-mode 1)

(setq blink-matching-paren t)
(setq show-paren-style 'parenthesis)
(setq show-paren-when-point-inside-paren t)
(show-paren-mode 1)
(electric-pair-mode 1)

(setq package-user-dir (expand-file-name "~/.cache/emacs/elpa"))
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package keycast)

(setq url-configuration-directory "~/.cache/emacs/")

(setq projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" user-emacs-directory)
      lsp-session-file (expand-file-name "lsp-session-v1" user-emacs-directory))

(setq gnus-init-file "~/.config/emacs/gnus.el")

(setq epg-pinentry-mode 'loopback)

(setq browse-url-browser-function 'eww-browse-url)

(use-package icomplete-vertical
  :config
  (fido-mode)
  (icomplete-vertical-mode)
  (setq fido-vertical-mode t)
  (setq icomplete-show-matches-on-no-input t)
  (setq completion-styles '(initials flex))
  (setq icomplete-hide-common-prefix nil)
  (setq completion-auto-help t))

(use-package which-key
:config
(which-key-mode)
(setq which-key-idle-delay 0.1))

(defun repeat-command (command)
  "Repeat command"
  (require 'repeat)
  (let ((repeat-previous-repeated-command command)
	(repeat-message-function #'ignore)
	(last-repeatable-command 'repeat))
    (repeat nil)))
(defun other-window-repeat ()
  "Select other window in cyclic version with last key press"
  (interactive)
  (repeat-command 'other-window))
(progn
  (define-prefix-command 'my-keymap)
  (define-key my-keymap (kbd "SPC") 'set-mark-command)
  (define-key my-keymap (kbd "C-SPC") 'set-mark-command)
  (define-key my-keymap (kbd "b") 'ibuffer)
  (define-key my-keymap (kbd "o") 'other-window-repeat)
  (define-key my-keymap (kbd "f") 'find-file)
  (define-key my-keymap (kbd "d") 'dired-other-window)
  (define-key my-keymap (kbd "e") 'eval-expression)
  (define-key my-keymap (kbd "i") 'imenu)
  (global-set-key (kbd "C-SPC") my-keymap))

(require 'org-tempo)

(use-package web-mode
:config
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode)))

(use-package dracula-theme
  :init
  (load-theme 'dracula t))
