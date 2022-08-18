;;; lang/elixir-web/config.el -*- lexical-binding: t; -*-

;; Inline template editing support for elixir via web-mode

(use-package! polymode)
(use-package! web-mode)
(use-package! elixir-mode)

(define-hostmode poly-elixir-mode
  "A polymode hostmode for elixir."
  :mode 'elixir-mode)

(define-innermode poly-eex-mode
  "A polymode innermode for inline (L|H)?EEx via web-mode."
  :mode 'web-mode
  :head-matcher (rx line-start (* space) "~" (or "H" "L") (= 3 (char "\"'")) line-end)
  :tail-matcher (rx line-start (* space) (= 3 (char "\"'")) line-end)
  :head-mode 'host
  :tail-mode 'host
  :allow-nested nil)

(define-polymode poly-elixir-web-mode
  "A polymode for elixir with templating support."
  :hostmode 'poly-elixir-hostmode
  :innermodes '(poly-eex-mode))

;;;###autoload (autoload 'poly-elixir-web-mode "config")
(define-polymode poly-elixir-web-mode
  "A polymode for elixir with templating support."
  :hostmode 'poly-elixir-hostmode
  :innermodes '(poly-eex-mode))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ex\\" . poly-elixir-web-mode))

;;;###autoload
(setq web-mode-engines-alist '(("elixir" . "\\.ex\\'")))
