;;备份目录自动生成，在保存的文件目录不存在是，它会自动生成目录
(add-hook 'before-save-hook
      '(lambda ()
         (or (file-exists-p (file-name-directory buffer-file-name))
         (make-directory (file-name-directory buffer-file-name) t))))
;;备份设置
    (setq make-backup-files t)
    (setq backup-directory-alist
          `((".*" . ,"~/.emacs.d/auto-backup/")))
    (setq auto-save-file-name-transforms
          `((".*" ,"~/.emacs.d/auto-save/" t)))
    (setq version-control t);;启用版本控制，即可以备份多次
    (setq kept-old-versions 2);;备份最原始的两次及第一次编辑前的文档和第二次编辑前的文档
    (setq kept-new-versions 5);;备份最新的版本1次，理解同上
    (setq delete-old-versions t);;删掉不属于以上3中版本的版本
    (setq backup-by-copying t);;备份设置方法，直接拷贝
    ;;(setq make-backup-files nil);; 设定不产生备份文件
    ;;(setq-default make-backup-files nil);; 不生成临时文件
    ;;(setq auto-save-mode nil) ;;自动保存模式
;; backup policies

(provide 'auto-backup-save)
