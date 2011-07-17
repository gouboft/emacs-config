;; Auto add bracket and quotation marks
(add-hook 'c-mode-hook 'hs-minor-mode)
(defun my-c-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
    (?` ?` _ "''")
    (?\( ?  _ " )")
    (?\[ ?  _ " ]")
    (?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
(add-hook 'c-mode-hook 'my-c-mode-auto-pair)

;; Enable line number
(global-linum-mode 1)
(column-number-mode 1)

;; Yasnippet settings
(defconst yasnippet-load-path
  (concat my-emacs-download-path "yasnippet-0.6.1c/snippets"))
(yas/initialize)
(yas/load-directory yasnippet-load-path)

(provide 'program-settings)