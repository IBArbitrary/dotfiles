;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Rajeshkumar K"
      user-mail-address "k.rajeshkumar.1411@gmail.com")

(setq-default
 delete-by-moving-to-trash t
 tab-width 4
 uniquify-buffer-name-style 'forward
 window-combination-resize t
 x-stretch-cursor t)

(setq undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t
      inhibit-compacting-font-caches t
      truncate-string-ellipsis "…"
      mouse-autoselect-window t)

(delete-selection-mode 1)
(display-time-mode 1)
(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))

(setq display-line-numbers-type 'relative)

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after 'evil-window-split 'evil-window-vsplit
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

(map! :map evil-window-map
      "SPC" #'rotate-layout
      ;; Navigation
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"       #'evil-window-up
      "<right>"    #'evil-window-right
      ;; Swapping windows
      "C-<left>"       #'+evil/window-move-left
      "C-<down>"       #'+evil/window-move-down
      "C-<up>"         #'+evil/window-move-up
      "C-<right>"      #'+evil/window-move-right)

(setq all-the-icons-color-icons t)

(defun doom-modeline-cond-buf-encoding ()
  (setq-local doom-modeling-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))
(add-hook 'after-change-major-mode-hook #'doom-modeline-cond-buf-encoding)

(setq doom-font (font-spec :family "Source Code Pro" :size 16)
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 16)
      doom-big-font (font-spec :familiy "Source Code Pro" :size 24))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq doom-theme 'doom-gruvbox)

(use-package keyfreq
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(setq org-directory "/media/storage/documents/org")
(setq org-noter-notes-search-path '("/media/storage/documents/org/noter"))
(after! org
  (setq org-agenda-files '("/media/storage/documents/org/agenda.org")
        org-ellipsis " [+]"
        org-log-done 'time
        org-hide-emphasis-markers t
        org-hide-leading-stars t
        org-superstar-leading-bullet ?\s
        org-startup-indented nil
        org-adapt-indentation nil
        org-tags-column -80))

(add-hook 'org-mode-hook (lambda ()
                           (setq org-hidden-keywords '(title author))
                           (set-face-attribute 'org-level-8 nil
                                               :weight 'bold
                                               :inherit 'default)
                           (set-face-attribute 'org-level-7 nil
                                               :inherit 'org-level-8)
                           (set-face-attribute 'org-level-6 nil
                                               :inherit 'org-level-8)
                           (set-face-attribute 'org-level-5 nil
                                               :inherit 'org-level-8)
                           (set-face-attribute 'org-level-4 nil
                                               :inherit 'org-level-8)
                           (set-face-attribute 'org-level-3 nil
                                               :inherit 'org-level-8
                                               :foreground "#b8bb26")
                           (set-face-attribute 'org-level-2 nil
                                               :inherit 'org-level-8
                                               :foreground "#fe8019")
                           (set-face-attribute 'org-level-1 nil
                                               :inherit 'org-level-8
                                               :foreground "#fabd2f")
                           (setq org-cycle-level-faces nil)
                           (setq org-n-level-faces 3)
                           (set-face-attribute 'org-document-title nil
                                               :foreground "#fb4934"
                                               :weight 'bold)
                           (set-face-attribute 'org-document-info nil
                                               :foreground "#83a598"
                                               :italic t)
                           (setq org-superstar-headline-bullets-list
                                 '("■" "◆" "●"))
                           (set-face-attribute 'org-drawer nil
                                               :inherit 'default
                                               :foreground "#504945")
                           (set-face-attribute 'org-special-keyword nil
                                               :inherit 'default
                                               :foreground "#665c54")))
(setq org-superstar-cycle-headline-bullets nil)

(add-hook 'org-mode-hook 'org-fragtog-mode)
(setq my-org-latex-preview-scale 1.5)
(defun org-latex-preview-advice (orig-func &rest args)
  (let ((old-val (copy-tree org-format-latex-options)))
    (setq org-format-latex-options
          (plist-put org-format-latex-options
                     :scale
                     (* my-org-latex-preview-scale
                        (expt
                         text-scale-mode-step text-scale-mode-amount))))
    (apply orig-func args)
    (setq org-format-latex-options old-val)))
(advice-add 'org-latex-preview :around #'org-latex-preview-advice )

(add-hook 'org-mode-hook
          (lambda ()
            (org-bullets-mode 1)
            (org-superstar-mode 1)
            ))

(setq deft-directory "/media/storage/documents/org"
      deft-extensions '("org" "txt" "md")
      deft-recursive t)

(after! org-ref
  (setq
   bibtex-completion-bibliography "/media/storage/documents/zotero/library.bib"
   bibtex-completion-pdf-field "file"
   )
  )

(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq
   org-noter-always-create-frame nil
   org-noter-hide-other nil
   )
  )

(setq TeX-view-program-selection '((output-pdf "zathura")))

(require 'lsp-python-ms)
(setq lsp-python-ms-auto-install-server t)
(add-hook 'python-mode-hook #'lsp)

(setq fancy-splash-image (concat doom-private-dir "splash-images/emacs-e.svg"))

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))

(defun doom-dashboard-draw-ascii-emacs-banner-fn ()
  (let* ((banner

          '("  ▄▄▄   ▄▄▄▄▄   ▄▄▄    ▄▄▄    ▄▄▄  "
            " █▀  █  █ █ █  ▀   █  █▀  ▀  █   ▀ "
            " █▀▀▀▀  █ █ █  ▄▀▀▀█  █       ▀▀▀▄ "
            " ▀█▄▄▀  █ █ █  ▀▄▄▀█  ▀█▄▄▀  ▀▄▄▄▀ "))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(unless (display-graphic-p) ; for some reason this messes up the graphical splash screen atm
  (setq +doom-dashboard-ascii-banner-fn #'doom-dashboard-draw-ascii-emacs-banner-fn))

(setq writegood-mode nil)
(setq spell-fu-mode 0)

(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(add-hook 'org-mode-hook
          (lambda ()
            (if (and (stringp buffer-file-name)
                     (string-match "/home/rajeshkumar/.config/doom/dotemacs.org"
                                   buffer-file-name))
                (add-hook 'after-save-hook #'org-babel-tangle
                          :append :local))))
