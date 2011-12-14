;; Start @_@
(defconst my-emacs-path           "~/.emacs.d/emacs-config/" "我的emacs相关配置文件的路径")
(defconst my-emacs-download-path  (concat my-emacs-path "download/") "我下载的emacs lisp包的路径")
(defconst my-emacs-my-lisps-path  (concat my-emacs-path "my-lisps/") "我自己写的emacs lisp包的路径")
(defconst my-emacs-templates-path (concat my-emacs-path "templates/") "Path for templates")

;; 把`my-emacs-lisps-path'的所有子目录都加到`load-path'里面
(load (concat my-emacs-my-lisps-path "my-subdirs"))
(my-add-subdirs-to-load-path my-emacs-download-path)
(my-add-subdirs-to-load-path my-emacs-my-lisps-path)

;; Auto backup and auto save config
(require 'auto-backup-save)

;; Server mode open
(server-start)
(global-set-key (kbd "C-,") 'server-edit)

;; Misc setting
(require 'misc-settings)

;; CEDET
(require 'cedet-settings)

;; ECB
(require 'ecb)
(require 'ecb-settings)

;; Recentf
(require 'recentf)
;(recentf-mode 1)

;; Face settings
(require 'face-settings)

;; Auto complete
;(require 'auto-complete-config)
;(ac-config-default)

;; Cscope
(add-hook 'c-mode-common-hook
	  '(lambda ()
	    (require 'xcscope)))
(setq cscope-do-not-update-database t)

;; Yasnippet
;; config in program-settings
(require 'yasnippet)

;; Program settings
(require 'program-settings)

;; Minibuffer complete
(require 'minibuffer-complete-cycle)

;; Active ECB, should place at last
(ecb-activate)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-name "right5")
 '(ecb-methods-menu-sorter (lambda (entries) (let ((sorted (copy-list entries))) (sort sorted (quote string-lessp)))))
 '(ecb-options-version "2.40")
 '(ecb-tip-of-the-day nil)
 '(ecb-windows-width 38)
 '(safe-local-variable-values (quote ((eval add-hook (quote write-file-hooks) (quote time-stamp))))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
