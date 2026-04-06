;;; proxy.el --- SOCKS proxy configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; SOCKS proxy setup for network requests

;;; Code:

;; SOCKS proxy configuration
(require 'socks)
(setq socks-noproxy '("localhost"))
(setq socks-server
      `("Default server" "127.0.0.1"
        ,(string-to-number (getenv "SOCKS_PORT")) 5))
(setq url-gateway-method 'socks)
;; Uncomment to disable SOCKS proxy:
;; (setq url-gateway-method 'native)

(provide 'proxy)
;;; proxy.el ends here
