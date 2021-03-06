;; Set C language style
(setq c-default-style "linux")
; C++ and JAVA file
(defun my-indent-offset-cpp ()
  (interactive)
  (setq c-basic-offset 4
        tab-width 8
        indent-tabs-mode nil))
(add-hook 'c++-mode-hook 'my-indent-offset-cpp)
(add-hook 'java-mode-hook 'my-indent-offset-cpp)
; C file
(defun my-indent-offset-c ()
  (interactive)
  (setq c-basic-offset 8
        tab-width 8
        indent-tabs-mode t))
(add-hook 'c-mode-hook 'my-indent-offset-c)

;; Auto add bracket and quotation marks
(add-hook 'c-mode-hook 'hs-minor-mode)
(defun my-c-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
    (?`  _ "'")
    (?\(  _ ")")
    (?\[  _ "]")
    (?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
(add-hook 'c-mode-hook 'my-c-mode-auto-pair)
(add-hook 'emacs-lisp-mode-hook 'my-c-mode-auto-pair)
(add-hook 'c++-mode-hook 'my-c-mode-auto-pair)
(add-hook 'java-mode-hook 'my-c-mode-auto-pair)

;; Enable line number
(global-linum-mode 1)
(column-number-mode 1)

;; Yasnippet settings
(defconst yasnippet-load-path
  (concat my-emacs-download-path "yasnippet-0.6.1c/snippets"))
(yas/initialize)
(yas/load-directory yasnippet-load-path)

;; High light symbol
(require 'highlight-symbol)
(global-set-key [f2] 'highlight-symbol-at-point)
(global-set-key [f4] 'highlight-symbol-next)
(global-set-key [f3] 'highlight-symbol-prev)

;; Goto line
(global-set-key [f5] 'goto-line)

;; Semantic jump setting
;; jump to define
(global-set-key [f8] 'semantic-ia-fast-jump)
;; jump back after jump to define
(global-set-key [f9]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))

;; Paren match highlighting
(show-paren-mode t)

;; For jde
;(require 'jde) ;; Never use it, and there will be an error when it open

;; Cscope keybinding
(define-key global-map [(meta n)]  'cscope-find-global-definition)  ;default: C-c s d
(define-key global-map [(meta \[)]  'cscope-find-this-symbol)  ;default: C-c s s
(define-key global-map [(meta \])]  'cscope-find-functions-calling-this-function)  ;default: C-c s c
(define-key global-map [(meta p)]  'cscope-pop-mark)  ;default: C-c s u


;; llvm
(require 'llvm-mode)
(require 'tablegen-mode)

;; Auto Complete
(require 'auto-complete-config)
(ac-config-default)

;; Clang complete
(require 'auto-complete-clang)
(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)
(ac-set-trigger-key "TAB")
(define-key ac-mode-map  [(control tab)] 'auto-complete)
(defun my-ac-config ()
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
    (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ac-source-gtags
(my-ac-config)

;; Template
(require 'template)
(template-initialize)

;; Column marker
(require 'column-marker)
;; C-c m to triger the highlight
(global-set-key [?\C-c ?m] 'column-marker-1)
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))

(defun my-c-mode-font-lock-if0 (limit)
   (save-restriction
     (widen)
     (save-excursion
       (goto-char (point-min))
       (let ((depth 0) str start start-depth)
         (while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)
           (setq str (match-string 1))
           (if (string= str "if")
               (progn
                 (setq depth (1+ depth))
                 (when (and (null start) (looking-at "\\s-+0"))
                   (setq start (match-end 0)
                         start-depth depth)))
             (when (and start (= depth start-depth))
               (c-put-font-lock-face start (match-beginning 0) 'font-lock-comment-face)
               (setq start nil))
             (when (string= str "endif")
               (setq depth (1- depth)))))
         (when (and start (> depth 0))
           (c-put-font-lock-face start (point) 'font-lock-comment-face)))))
   nil)

(defun my-c-mode-common-hook-if0 ()
   (font-lock-add-keywords
    nil
    '((my-c-mode-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook-if0)

;; comment or uncomment
(global-set-key [?\C-c ?\C-/] 'comment-or-uncomment-region)

;; 十六进制模式 Hex mode
;; M-x hexl-mode

(provide 'program-settings)
