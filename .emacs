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

;; Misc setting
(require 'misc-settings)

;; CEDET
(require 'cedet-settings)

;; ECB
(require 'ecb)
(require 'ecb-settings)

;; Recentf
(require 'recentf)
(recentf-mode 1)

;; Face settings
(require 'face-settings)

;; Auto complete
(require 'auto-complete-config)
(ac-config-default)

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
