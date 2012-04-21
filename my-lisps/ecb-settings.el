;; ECB configuration
(custom-set-variables
 '(ecb-options-version "2.40")
 '(ecb-tip-of-the-day nil)
 '(ecb-windows-width 38)
 '(ecb-layout-name "right5")
 '(ecb-methods-menu-sorter (lambda (entries) (let ((sorted (copy-list entries))) (sort sorted (quote string-lessp))))))
(custom-set-faces
)


;; Key settings
(global-set-key (kbd "C-l") 'ecb-goto-window-methods)
(global-set-key (kbd "C-x ;") 'ecb-goto-window-sources)
(global-set-key (kbd "C-'") 'ecb-goto-window-edit1)
(global-set-key (kbd "C-;") 'ecb-goto-window-edit2)
(global-set-key (kbd "C-x {") 'ecb-activate)
(global-set-key (kbd "C-x }") 'ecb-deactivate)

(provide 'ecb-settings)
