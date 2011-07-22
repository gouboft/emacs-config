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

;; Yes or No to y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Input Methods
(require 'eim-extra)
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


(provide 'misc-settings)
