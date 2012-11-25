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

;; Clang complete
(load-library "clang-completion-mode")
;(require 'clang-completion-mode)
(define-key global-map [(meta \-)]  'clang-completion-mode)

;; Template
(require 'template)
(template-initialize)

(provide 'program-settings)
