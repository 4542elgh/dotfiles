(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

(package-initialize)

;;; If use-pacakge is not installed, instll it first before requiring
(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

(require 'use-package)

(add-hook 'emacs-startup-hook 'treemacs)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-projects-backend 'projectile)
  (add-to-list 'dashboard-items '(projects . 5))
)

(set-frame-font "DejaVu Sans Mono 11" nil t)

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(setq load-prefer-newer t)

(setq use-package-always-ensure t)

(scroll-bar-mode -1)

(blink-cursor-mode 0)

(use-package lsp-mode
  :hook (
    (mhtml-mode . lsp)
    (js-mode . lsp)
    (lsp-mode . lsp-enable-which-key-integration)
  )
  :commands (lsp lsp-deferred)
   :custom
  (lsp-headerline-breadcrumb-enable t)
)

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode
)

; --- LSP tuning starts 
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-idle-delay 0.500)
(setq lsp-log-io nil) 
; --- LSP tuning ends

;; (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

  ; This enables copy by cursor selection
  (setq x-select-enable-primary t)


  ; Remove number line when in eshell mode
  (add-hook 'eshell-mode-hook
    (lambda () (setq-local display-line-numbers-type nil))
  )

  ; Set startup screen is eshell
  (setq initial-buffer-choice 'eshell)

  ; Flycheck for emacs init is annoying, disable it for now
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc emacs-lisp))

  ;; mode line time stamp
  (setq display-time-24hr-format t)
  (setq display-time-format "%H:%M:%S")        ; add seconds
  (setq display-time-default-load-average nil)
  (setq display-time-interval 1)               ; update every second
  (display-time-mode 1)                 ; show time in mode line on startup

  ; Set evil state tags
  (setq evil-normal-state-tag "NORMAL")
  (setq evil-insert-state-tag "INSERT")
  (setq evil-visual-state-tag "VISUAL")

  ;;; Install Darcula theme, download it if not presented
  (use-package jetbrains-darcula-theme
    :config (load-theme 'jetbrains-darcula t)
  )

  ;;; Install evil mode, VIM KEY BIND LETS GOOOOOO
  (use-package evil
    :init
      (setq evil-want-keybinding nil)
      ; Evil mode set Ctrl-U to scroll up. Make sure to put this before require evil mode
      (setq evil-want-C-u-scroll t)
      (setq evil-want-C-i-jump nil)
      (setq evil-undo-system 'undo-fu)
    :config
      (evil-mode) 
  )

  (use-package evil-collection
    :after evil
    :config (evil-collection-init)
  )

  ;; (define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
  ;; (define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
  ;; (define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
  ;; (define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)

  ;;; unbind Evil Mode Ctrl-P to swiper (this needs to be at least after Evil Mode loaded)
  (define-key evil-normal-state-map (kbd "C-p") nil)
  (define-key evil-emacs-state-map (kbd "C-z") nil)

  ;;; Auto complete commands
  (use-package ivy
    :defer 0.1
    :diminish
    :config (ivy-mode)
    (define-key ivy-minibuffer-map (kbd "C-j") #'ivy-next-line)
    (define-key ivy-minibuffer-map (kbd "C-k") #'ivy-previous-line)
    ; Swiper mapped C-K to kill buffer, need to remap that to previous line
    (define-key ivy-switch-buffer-map (kbd "C-k") #'ivy-previous-line)
    (define-key ivy-switch-buffer-map (kbd "C-x") #'ivy-switch-buffer-kill)
  )

  (use-package ivy-rich
    :init (ivy-rich-mode 1)
  )

  (use-package counsel
    :after ivy
    :config
      (setcdr (assoc 'counsel-M-x ivy-initial-inputs-alist) "")
  )

  (use-package swiper
    :after ivy
    :bind (
      ("C-p" . swiper)
    )
  )

  (use-package which-key
    :config (which-key-mode)
  )

  (use-package helpful
    :custom
    (counsel-describe-function-function #'helpful-callable)
    (counsel-describe-variable-function #'helpful-variable)
    :bind
    ([remap describe-function] . counsel-describe-function)
    ([remap describe-command] . helpful-command)
    ([remap describe-variable] . counsel-describe-variable)
    ([remap describe-key] . helpful-key) 
  )

  (use-package flycheck
    :config
    (global-flycheck-mode)
  )

  (use-package rainbow-delimiters
    :init (
      add-hook 'prog-mode-hook #'rainbow-delimiters-mode
    )
  )

  (use-package key-chord
    :ensure t
    :config (key-chord-mode 1)
    (key-chord-define-global " x" 'counsel-M-x)
    (key-chord-define-global " a" 'counsel-linux-app)
    (key-chord-define-global "xb" 'delete-window)
    ;; (key-chord-define-global " b" 'counsel-switch-buffer)
    (key-chord-define-global "cc" 'comment-line)
    (key-chord-define-global " n" 'treemacs)
    ;; (key-chord-define-global " t" 'eshell)
    (key-chord-define-global " p" 'counsel-projectile-rg)
  )

  (use-package spaceline
    :config (spaceline-emacs-theme)
  )

(use-package nyan-mode
  :config (setq nyan-mode t)
)

  ;; (use-package web-mode
  ;;   :ensure t
  ;; )

  ;; (use-package lsp-treemacs
  ;;   :after treemacs
  ;;   :config
  ;;   (lsp-treemacs-sync-mode 1)
  ;; )

  ;; (use-package auto-complete
  ;;   :config (ac-config-default)
  ;; (setq ac-sources '(ac-source-yasnippet
  ;; ac-source-abbrev
  ;; ac-source-words-in-same-mode-buffers))
  ;; )

  (use-package yasnippet
    :after lsp-mode
    :config (yas-global-mode 1)
    (define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)
  )

  (use-package yasnippet-snippets
    :after yasnippet
  )

  (use-package company
    ;; :config (add-to-list 'company-backends '(company-yasnippet))
  )

  (use-package undo-fu)

  (use-package projectile
    :diminish projectile-mode
    :config (projectile-mode)
    :custom ((projectile-completion-system 'ivy))
    :bind-keymap
    ("C-c p" . projectile-command-map)
    :init
    (when (file-directory-p "~/Dev")
      (setq projectile-project-search-path '("~/Dev")))
    (setq projectile-switch-project-action #'projectile-dired)
  )

  (use-package counsel-projectile
    :config (counsel-projectile-mode)
  )

  (use-package magit)

  (use-package treemacs
    :config
      (treemacs-follow-mode t)
      (treemacs-filewatch-mode t)
      (add-to-list 'projectile-globally-ignored-directories "node_modules")
      (setq projectile-indexing-method 'native)
  )


  (use-package treemacs-evil
    :after treemacs evil
  )

  (use-package treemacs-projectile
    :after treemacs projectile
  )

  (use-package json-mode)

  ;; (use-package elcord
  ;;   :config (elcord-mode)
  ;; )

  (use-package perspective
    :config
    (persp-mode)
  )

  (defun efs/org-mode-setup ()
    (org-indent-mode)
    (variable-pitch-mode 1)
    (visual-line-mode 1))


    ;; Set faces for heading levels
    (dolist (face '((org-level-1 . 1.2)
                    (org-level-2 . 1.1)
                    (org-level-3 . 1.05)
                    (org-level-4 . 1.0)
                    (org-level-5 . 1.1)
                    (org-level-6 . 1.1)
                    (org-level-7 . 1.1)
                    (org-level-8 . 1.1)))
  )

  (use-package org
    :hook (org-mode . efs/org-mode-setup)
    (org-mode . (lambda () (require 'org-tempo)))
    :config
    (setq org-ellipsis " ▾")
    (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  )

  (use-package org-bullets
    :after org
    :hook (org-mode . org-bullets-mode)
    :custom
    (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

  (defun efs/org-mode-visual-fill ()
    (setq visual-fill-column-width 100
          visual-fill-column-center-text t)
    (visual-fill-column-mode 1))

  (use-package visual-fill-column
    :hook (org-mode . efs/org-mode-visual-fill))

  (add-hook 'org-mode-hook '(lambda () (setq display-line-numbers-type nil)))

  ;; (use-package evil-magit
  ;;   :after magit
  ;; )

  ;; (use-package exwm
  ;;   :ensure t
  ;;   :config
  ;;     (require 'exwm-config)
  ;;     (exwm-config-default)
  ;;     (server-start)
  ;; )

  ; Define shortcuts
  (global-set-key (kbd "<f1>") (lambda() (interactive)(find-file "~/.config/emacs/init.org")))
  (global-set-key (kbd "<f2>") (lambda() (interactive)(find-file "~/.config/emacs/init.el")))
  (global-set-key (kbd "C-c t") 'eshell)
  (global-set-key (kbd "C-c b") 'counsel-switch-buffer)

  (define-key key-translation-map (kbd "ESC") (kbd "C-g"))

  ; Define Evil mode binding to Vim-Like behavior
  (define-key evil-motion-state-map ";" #'evil-ex)
  (define-key evil-motion-state-map ":" #'evil-repeat-find-char)

  
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(elcord evil-magit magit counsel-projectile key-chord swiper ivy use-package jetbrains-darcula-theme evil)))
  
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
