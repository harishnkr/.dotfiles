;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "K. Harishankar"
      user-mail-address "hari2menon1234@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Code" :size 18 :weight 'semi-light)
     doom-variable-pitch-font (font-spec :family "Fira Sans" :size 20))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Sync/Notes/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq
projectile-project-search-path '("~/")
)
;; Add LilyPond major mode
(use-package! lilypond-mode
  :mode "\\.ly\\'"
  :config
  (setq lilypond-program "lilypond"))
(after! eshell
  (add-hook 'eshell-mode-hook #'evil-emacs-state))
(setq +latex-viewers '(pdf-tools))  ;; Enable PDF Tools
(after! pdf-tools
  (setq-default pdf-view-display-size 'fit-page)
  (add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode)))

(add-hook 'LaTeX-mode-hook #'xenops-mode)
(after! cdlatex
  (map! :map cdlatex-mode-map
        :i "TAB" #'cdlatex-tab))  ;; This will bind TAB to cdlatex-tab in insert mode
(setq deft-directory "~/Sync/Notes"
      deft-extensions '("org")
      deft-recursive t)

(setq org-journal-date-prefix "#+TITLE:"
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")

(setq org-roam-directory "~/Sync/Notes/")
(setq org-roam-file-exclude-regexp ".*\\.gpg$")

(after! org
  (require 'ox-pandoc))
(map! :leader
      :desc "Switch buffer" "SPC" #'consult-buffer)
;; (after! org
;;   (require 'oc)
;;   (require 'oc-biblatex)
;;   (setq org-cite-export-processors '((latex biblatex) (t csl))))

;; (after! oc
;;   (setq org-cite-insert-processor 'citar
;;         org-cite-follow-processor 'citar
;;         org-cite-activate-processor 'citar))
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-visual-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
(define-key evil-visual-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)

(after! ein
;; Open notebook in same window
  (setf (alist-get "\\*ein:.*\\.ipynb\\*" display-buffer-alist nil nil #'equal)
        '((display-buffer-same-window)))

  (add-hook 'ein:notebook-mode-hook #'evil-normalize-keymaps)
  (add-hook 'ein:notebook-mode-hook #'evil-local-mode))
