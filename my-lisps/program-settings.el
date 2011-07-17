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
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [f4] 'highlight-symbol-prev)

;; Goto line
(global-set-key [f5] 'goto-line)

(provide 'program-settings)