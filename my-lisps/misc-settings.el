;; When shell was exit, close the buffer
(add-hook 'shell-mode-hook 'wcy-shell-mode-hook-func)
(defun wcy-shell-mode-hook-func  ()
  (set-process-sentinel (get-buffer-process (current-buffer))
                            #'wcy-shell-mode-kill-buffer-on-exit)
      )
(defun wcy-shell-mode-kill-buffer-on-exit (process state)
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

(provide 'misc-settings)