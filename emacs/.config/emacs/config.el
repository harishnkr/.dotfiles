(defvar elpaca-installer-version 0.5)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
			:ref nil
			:files (:defaults (:exclude "extensions"))
			:build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
 (build (expand-file-name "elpaca/" elpaca-builds-directory))
 (order (cdr elpaca-order))
 (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
  (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
	   ((zerop (call-process "git" nil buffer t "clone"
				 (plist-get order :repo) repo)))
	   ((zerop (call-process "git" nil buffer t "checkout"
				 (or (plist-get order :ref) "--"))))
	   (emacs (concat invocation-directory invocation-name))
	   ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
				 "--eval" "(byte-recompile-directory \".\" 0 'force)")))
	   ((require 'elpaca))
	   ((elpaca-generate-autoloads "elpaca" repo)))
      (kill-buffer buffer)
    (error "%s" (with-current-buffer buffer (buffer-string))))
((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable :elpaca use-package keyword.
  (elpaca-use-package-mode)
  ;; Assume :elpaca t unless otherwise specified.
  (setq elpaca-use-package-by-default t))

;; Block until current queue processed.
(elpaca-wait)

;; Expands to: (elpaca evil (use-package evil :demand t))
      (use-package evil
          :init      ;; tweak evil's configuration before loading it
          (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
          (setq evil-want-keybinding nil)
          (setq evil-vsplit-window-right t)
          (setq evil-split-window-below t)
          (setq evil-want-C-u-scroll t) ;; Use C-u to scroll instead of emacs function to work
          :config
          (evil-mode)
    ;; Use visual line motions even outside of visual-line-mode buffers
      (evil-global-set-key 'motion "j" 'evil-next-visual-line)
      (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
;; redo functionality control r like vim
  (evil-set-undo-system 'undo-redo)
    )
      (use-package evil-collection
          :after evil
          :config
          (evil-collection-init))
      (use-package evil-tutor)

(use-package general
  :config
  (general-evil-setup)

   ;; set up 'SPC' as the global leader key
   (general-create-definer vi/leader-keys
     :states '(normal insert visual emacs)
     :keymaps 'override
     :prefix "SPC" ;; set leader
     :global-prefix "M-SPC") ;; access leader in insert mode


   (vi/leader-keys
     "b" '(:ignore t :wk "Buffer")
     "b b" '(switch-to-buffer :wk "Switch buffer")
     "b i" '(ibuffer :wk "Ibuffer")
     "b k" '(kill-this-buffer :wk "Kill this buffer")
     "b n" '(next-buffer :wk "Next buffer")
     "b p" '(previous-buffer :wk "Previous buffer")
     "b r" '(revert-buffer :wk "Reload buffer"))

   (vi/leader-keys
     "e" '(:ignore t :wk "Evaluate")    
     "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
     "e d" '(eval-defun :wk "Evaluate defun containing or after point")
     "e e" '(eval-expression :wk "Evaluate and elisp expression")
     "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
     "e r" '(eval-region :wk "Evaluate elisp in region"))

   (vi/leader-keys
     "f" '(:ignore t :wk "File:")    
     "f f" '(find-file :wk "Find file")
     "f c" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit emacs config")
     "f t" '((lambda () (interactive) (find-file "~/Org/Tasks.org")) :wk "Edit Tasks")
     "f r" '(counsel-recentf :wk "Find recent files")

     "TAB TAB" '(comment-line :wk "Comment lines"))

  (vi/leader-keys
     "h" '(:ignore t :wk "Help")
     "h f" '(describe-function :wk "Describe function")
     "h v" '(describe-variable :wk "Describe variable")
     ;;"h r r" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "Reload emacs config")
     "h r r" '(reload-init-file :wk "Reload emacs config"))

   (vi/leader-keys
     "s" '(:ignore t :wk "Eshell")    
     "s h" '(counsel-esh-history :which-key "Eshell history")
     "s s" '(eshell :which-key "Eshell"))

   (vi/leader-keys
     "t" '(:ignore t :wk "Toggle")
     "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
     "t t" '(visual-line-mode :wk "Toggle truncated lines")
     "t v" '(vterm-toggle :wk "Toggle vterm"))

   (vi/leader-keys
     "w" '(:ignore t :wk "Windows")
     ;; Window splits
     "w c" '(evil-window-delete :wk "Close window")
     "w n" '(evil-window-new :wk "New window")
     "w s" '(evil-window-split :wk "Horizontal split window")
     "w v" '(evil-window-vsplit :wk "Vertical split window")
     ;; Window motions
     "w h" '(evil-window-left :wk "Window left")
     "w j" '(evil-window-down :wk "Window down")
     "w k" '(evil-window-up :wk "Window up")
     "w l" '(evil-window-right :wk "Window right")
     "w w" '(evil-window-next :wk "Goto next window")
     ;; Move Windows
     "w H" '(buf-move-left :wk "Buffer move left")
     "w J" '(buf-move-down :wk "Buffer move down")
     "w K" '(buf-move-up :wk "Buffer move up")
     "w L" '(buf-move-right :wk "Buffer move right"))
 )

(require 'windmove)

;;;###autoload
(defun buf-move-up ()
  "Swap the current buffer and the buffer above the split.
If there is no split, ie now window above the current one, an
error is signaled."
;;  "Switches between the current buffer, and the buffer above the
;;  split, if possible."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'up))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No window above this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-down ()
"Swap the current buffer and the buffer under the split.
If there is no split, ie now window under the current one, an
error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'down))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (or (null other-win) 
            (string-match "^ \\*Minibuf" (buffer-name (window-buffer other-win))))
        (error "No window under this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-left ()
"Swap the current buffer and the buffer on the left of the split.
If there is no split, ie now window on the left of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'left))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No left split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-right ()
"Swap the current buffer and the buffer on the right of the split.
If there is no split, ie now window on the right of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'right))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No right split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

(use-package flycheck
  :diminish
  :ensure t
  :defer t
  :init (global-flycheck-mode))

(set-face-attribute 'default nil
  :font "Fira Code Nerd Font"
  :height 150
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Cantarell"
  :height 150
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "Fira Code Nerd Font"
  :height 150
  :weight 'medium)


;; Uncomment the following line if line spacing needs adjusting.
;; (setq-default line-spacing 0.12)

(use-package ligature
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
  (column-number-mode 1)
  (global-visual-line-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package diminish)

(use-package rainbow-delimiters)

(use-package rainbow-mode
  :diminish
  :hook 
  ((org-mode prog-mode) . rainbow-mode))

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
(load-theme 'kerala t)

(use-package vertico
  :ensure t
  :bind (:map vertico-map
              ("C-j" . vertico-next)
              ("C-k" . vertico-previous)
              ("C-f" . vertico-exit)
              :map minibuffer-local-map
              ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (setq savehist-mode t)
  (setq vertico-mode t))


(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package magit)

(setq org-agenda-start-with-log-mode t)
    (setq org-log-done 'time)
    (setq org-log-into-drawer t)
  (setq org-agenda-files
          '("~/Org/Tasks.org"
            "~/Org/Journal.org"
            "~/Org/Birthdays.org"))

(setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

(setq org-tag-alist
    '((:startgroup)
       ; Put mutually exclusive tags here
       (:endgroup)
       ("@errand" . ?E)
       ("@home" . ?H)
       ("@work" . ?W)
       ("agenda" . ?a)
       ("planning" . ?p)
       ("publish" . ?P)
       ("batch" . ?b)
       ("note" . ?n)
       ("idea" . ?i)))

  ;; Configure custom agenda views
    (setq org-agenda-custom-commands
     '(("d" "Dashboard"
       ((agenda "" ((org-deadline-warning-days 7)))
        (todo "NEXT"
          ((org-agenda-overriding-header "Next Tasks")))
        (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

      ("n" "Next Tasks"
       ((todo "NEXT"
          ((org-agenda-overriding-header "Next Tasks")))))

      ("W" "Work Tasks" tags-todo "+work-email")

      ;; Low-effort next actions
      ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
       ((org-agenda-overriding-header "Low Effort Tasks")
        (org-agenda-max-todos 20)
        (org-agenda-files org-agenda-files)))

      ("w" "Workflow Status"
       ((todo "WAIT"
              ((org-agenda-overriding-header "Waiting on External")
               (org-agenda-files org-agenda-files)))
        (todo "REVIEW"
              ((org-agenda-overriding-header "In Review")
               (org-agenda-files org-agenda-files)))
        (todo "PLAN"
              ((org-agenda-overriding-header "In Planning")
               (org-agenda-todo-list-sublevels nil)
               (org-agenda-files org-agenda-files)))
        (todo "BACKLOG"
              ((org-agenda-overriding-header "Project Backlog")
               (org-agenda-todo-list-sublevels nil)
               (org-agenda-files org-agenda-files)))
        (todo "READY"
              ((org-agenda-overriding-header "Ready for Work")
               (org-agenda-files org-agenda-files)))
        (todo "ACTIVE"
              ((org-agenda-overriding-header "Active Projects")
               (org-agenda-files org-agenda-files)))
        (todo "COMPLETED"
              ((org-agenda-overriding-header "Completed Projects")
               (org-agenda-files org-agenda-files)))
        (todo "CANC"
              ((org-agenda-overriding-header "Cancelled Projects")
               (org-agenda-files org-agenda-files)))))))

(setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

(setq org-capture-templates
   `(("t" "Tasks / Projects")
     ("tt" "Task" entry (file+olp "~/Org/Tasks.org" "Inbox")
          "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

     ("j" "Journal Entries")
     ("jj" "Journal" entry
          (file+olp+datetree "~/Org/Journal.org")
          "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
          ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
          :clock-in :clock-resume
          :empty-lines 1)
     ("jm" "Meeting" entry
          (file+olp+datetree "~/Org/Journal.org")
          "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
          :clock-in :clock-resume
          :empty-lines 1)

     ("w" "Workflows")
     ("we" "Checking Email" entry (file+olp+datetree "~/Org/Journal.org")
          "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

     ("m" "Metrics Capture")
     ("mw" "Weight" table-line (file+headline "~/Org/Metrics.org" "Weight")
      "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

 (define-key global-map (kbd "C-c j")
   (lambda () (interactive) (org-capture nil "jm")))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)))

(setq org-confirm-babel-evaluate nil)

;; Automatically tangle our Emacs.org config file when we save it
(defun babel/org-babel-tangle-config ()
  (when (and (string-equal (file-name-nondirectory (buffer-file-name)) "config.org")
             (string-equal (file-name-directory (buffer-file-name)) (expand-file-name user-emacs-directory)))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'babel/org-babel-tangle-config nil 'local)))

(defun org-mode-setup ()
  (org-indent-mode 1)
  (variable-pitch-mode 0)
  (visual-line-mode 1)
  (setq org-hide-emphasis-markers t))

(add-hook 'org-mode-hook 'org-mode-setup)

(defun org-font-setup ()

   ;; Ensure that anything that should be fixed-pitch in Org files appears that way
   (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
   (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
   (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
   (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
   (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
   (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
   (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
   (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
   (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
   (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
   (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))


(add-hook 'org-mode-hook 'org-font-setup)

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(use-package org-roam
  :ensure t
  :demand t  ;; Ensure org-roam is loaded by default
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Org/Roam")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n I" . org-roam-node-insert-immediate)
         ("C-c n p" . my/org-roam-find-project)
         ("C-c n t" . my/org-roam-capture-task)
         ("C-c n b" . my/org-roam-capture-inbox)
         :map org-mode-map
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  (org-roam-db-autosync-mode))

(use-package org-superstar
      :init
      (add-hook 'org-mode-hook #'org-superstar-mode)
      :config
      (setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●"))
      (setq org-superstar-item-bullet-alist '((?+ . ?◦) (?- . ?◦)))
      ;; This is usually the default, but keep in mind it must be nil
      (setq org-hide-leading-stars nil)
;; This line is necessary.
(setq org-superstar-leading-bullet ?\s)
;; If you use Org Indent you also need to add this, otherwise the
;; above has no effect while Indent is enabled.
(setq org-indent-mode-turns-on-hiding-stars nil)
(setq org-ellipsis " ▾"))

(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(defun orgm/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . orgm/org-mode-visual-fill))

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(setq inhibit-splash-screen t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(defun reload-init-file ()
  (interactive)
  (load-file user-init-file)
  (load-file user-init-file))

(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
;; eshell-aliases-file -- sets an aliases file for the eshell.
  
(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

(use-package vterm
:config
(setq shell-file-name "/bin/zsh"
      vterm-max-scrollback 5000))

(use-package vterm-toggle
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  ;;(display-buffer-reuse-window display-buffer-in-direction)
                  ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                  ;;(direction . bottom)
                  ;;(dedicated . t) ;dedicated is supported in emacs27
                  (reusable-frames . visible)
                  (window-height . 0.3))))

(use-package sudo-edit
  :config
    (vi/leader-keys
      "fu" '(sudo-edit-find-file :wk "Sudo find file")
      "fU" '(sudo-edit :wk "Sudo edit file")))

(use-package which-key
  :diminish
  :init
    (which-key-mode 1)
  :config
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.3
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit nil
        which-key-separator " → " ))
