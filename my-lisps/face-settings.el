;; Full screen setting
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
  (set-frame-parameter nil 'fullscreen
		       (if (equal 'fullboth current-value)
			   (if (boundp 'old-fullscreen) old-fullscreen nil)
			   (progn (setq old-fullscreen current-value)
				  'fullboth)))))
(global-set-key [f11] 'toggle-fullscreen)
; Make new frames fullscreen by default. Note: this hook doesn't do
; anything to the initial frame if it's in your .emacs, since that file is
; read _after_ the initial frame is created.
(add-hook 'after-make-frame-functions 'toggle-fullscreen)

;; Maximized windows setting
(defun maximized-screen (&optional f)
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
   		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(if window-system
    (progn
      (maximized-screen)))

;; Vim mode
(require 'vim)
(vim-mode 1)

(provide 'face-settings)