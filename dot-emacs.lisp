; ===== EMACS dot file =====

; load themes folder and set theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
; download zenburn theme from here: https://github.com/bbatsov/zenburn-emacs
(load-theme 'zenburn t)

; enable MELPA stable repositories for your emacs
; install packages using M-x package-install RET [package name]
(require 'package)
(add-to-list 'package-archives
	     '("MELPA Stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

; load plugins folder
(add-to-list 'load-path "~/.emacs.d/plugins")
; set backup files folder
(setq backup-directory-alist
      (quote (("." . "~/.emacs-backups"))))

; fix required for running emacs from Mac OS X finder or spotlight search apps
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

; mode helpful for switching between buffers, navigating between files, folders
(ido-mode 1)
; shows matching parantheses when editing a buffer
(show-paren-mode 1)
; display column number while navigating in a buffer
(column-number-mode 1)
; show traling whitespaces when editing in a buffer
(setq-default show-trailing-whitespace t)
; no toolbar display to win screen display and be cool :)
(tool-bar-mode -1)
; no menu display to win screen display and be cool :)
(menu-bar-mode -1)
; no scrollbar display to win screen display and be cool :)
(scroll-bar-mode -1)
; always use spaces, not tabs, when indenting
(setq indent-tabs-mode -1)

; line length highlighter
(require 'column-marker)
(add-hook 'prog-mode-hook (lambda () (interactive) (column-marker-1 80)))

; differentiate between buffers with same name but different location
(require 'uniquify)
(setq
 uniquify-buffer-name-style 'post-forward
 uniquify-separator ":")

; refreshes all open buffers from their respective files
(defun refresh-all-buffers ()
  (interactive)
  (let* ((list (buffer-list))
         (buffer (car list)))
    (while buffer
      (when (and (buffer-file-name buffer)
                 (not (buffer-modified-p buffer)))
        (set-buffer buffer)
        (revert-buffer t t t))
      (setq list (cdr list))
      (setq buffer (car list))))
  (message "Refreshed open files"))
(global-set-key [(control shift tab)] 'refresh-all-buffers)

; ===== Python development setup =====

; setup Flycheck static code analyser for Python
(add-hook 'after-init-hook #'global-flycheck-mode)


