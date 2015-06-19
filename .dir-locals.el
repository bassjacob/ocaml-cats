((nil
  . ((eval
      . (let ((default-directory (file-name-directory
                                  (let ((d (dir-locals-find-file ".")))
                                    (if (stringp d) d (car d))))))
          (setq-default utop-command (concat "utop -emacs -init " (expand-file-name ".ocamlinit"))))))))
