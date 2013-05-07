;; When shell was exit, close the buffer
(add-hook 'shell-mode-hook 'shell-mode-hook-func)
(defun shell-mode-hook-func  ()
  (set-process-sentinel (get-buffer-process (current-buffer))
                            #'shell-mode-kill-buffer-on-exit)
      )
(defun shell-mode-kill-buffer-on-exit (process state)
  (message "%s" state)
  (if (or
       (string-match "exited abnormally with code.*" state)
       (string-match "finished" state))
      (kill-buffer (current-buffer))))

;; Disable Tool bar and Scroll bar
(tool-bar-mode nil)
(scroll-bar-mode nil)

;; Desktop mode open
(require 'desktop)
(desktop-save-mode 1)

;; Modify the title of the emacs
(setq frame-title-format "%f@%b")

;; Support the copy/past between emacs and other app
(setq x-select-enable-clipboard t)

;; Yes or No to y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Input Methods
;; 如果你忘了怎么启动这个中文输入法，那就按C-\。
(autoload 'eim-use-package "eim" "Another emacs input method")
(setq eim-use-tooltip nil)              ; don't use tooltip
(setq eim-punc-translate-p nil)         ; use English punctuation
(register-input-method
 "chinese-wubi" "euc-cn" 'eim-use-package
 "五" "EIM Wubi Input Method" "wb.txt"
 'my-eim-wb-activate-function)
(defun my-eim-wb-activate-function ()
  (add-hook 'eim-active-hook 
        (lambda ()
          (let ((map (eim-mode-map)))
            (define-key map "-" 'eim-previous-page)
            (define-key map "=" 'eim-next-page)))))
(setq eim-wb-use-gbk t)
;; Set wubi for the default input method
(setq default-input-method 'chinese-wubi)
;; 用 ; 暂时输入英文
(require 'eim-extra)
(global-set-key ";" 'eim-insert-ascii)
(global-set-key (kbd "M-?") 'eim-punc-translate-toggle)

; Ibuffer mode
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; ido
(require 'ido)
(ido-mode 1)

;; Show killing-ring
(require 'browse-kill-ring+)
(global-set-key "\C-cy" '(lambda ()
                         (interactive)
                         (popup-menu 'yank-menu)))

;; W3m configuration
(setq w3m-default-display-inline-images t)

;; iimage mode
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)
(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
      (set-face-underline-p 'org-link t))
  (iimage-mode))
(add-hook 'org-mode-hook 'iimage-mode)

;; Org mode
(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(i!)" "HANGUP(h@/!)" "|" "DONE(d@!)" "CANCEL(c@!)")))
;; Auto word wrap
(add-hook 'org-mode-hook
      (lambda ()
        (setq truncate-lines nil)))
;;Hide stars and insert timestamp and note when task was done
(setq org-hide-leading-stars t)
(setq org-log-done 'time)
(setq org-log-done 'note)

;; Markdown-mode
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.text" . markdown-mode) auto-mode-alist))

;; Next / Previous buffer key bonding
(global-set-key "\C-xn" 'next-buffer)
(global-set-key "\C-xp" 'previous-buffer)

;; Add the chinese-gbk coding
(prefer-coding-system 'chinese-gbk)
(prefer-coding-system 'utf-8)

(provide 'misc-settings)
