;; ECB configuration
(custom-set-variables
 '(ecb-options-version "2.40")
 '(ecb-tip-of-the-day nil)
 '(ecb-windows-width 38)
 '(ecb-layout-name "right3")
 '(ecb-methods-menu-sorter (lambda (entries) (let ((sorted (copy-list entries))) (sort sorted (quote string-lessp))))))
(custom-set-faces
)


(provide 'ecb-settings)