;;; generate-karabiner-config.el --- Generate config private.xml of Karabiner -*- coding: utf-8; lexical-binding: t -*-

;; Copyright (C) 2016  Ken Okada

;; Author: Ken Okada <keno.ss57@gmail.com>
;; Keywords: 
;; URL: https://github.com/kenoss
;; Package-Requires: ((emacs "24"))

;; Apache License, Version 2.0

;;; Commentary:

;; 

;;; Code:


(eval-when-compile
  (require 'cl)
  (require 'erfi-macros)
  (erfi:use-short-macro-name))

(require 'erfi-srfi-1)
(require 'erfi-srfi-13)
(require 'erfi-gauche)
(require 'web-mode)



;;;
;;; Variables
;;;

;(defvar gkc-meta-key-abbrev-string-alist
(setq gkc-meta-key-abbrev-string-alist
  '(("C"  . ("CONTROL_L"))
    ("s"  . ("SHIFT_L"))
    ("c"  . ("COMMAND_L"))
    ("o"  . ("OPTION_L"))
    ("or" . ("OPTION_R"))
    ("cl" . ("COMMAND_L"))
    ("cr" . ("COMMAND_R"))
    ("SANDS2" . ("SANDS2"))
    ("S"  . ("COMMAND_L" "OPTION_L"))
    ("H"  . ("OPTION_R"))
    ))

;(defvar gkc-key-string-key-code-alist
(setq gkc-key-string-key-code-alist
  `(,@(mapcar (lambda (str) (cons str str))
              (append '("SHIFT_R" "SHIFT_L" "CONTROL_L" "CONTROL_R" "COMMAND_L" "COMMAND_R" "OPTION_L" "OPTION_R"
                        "TAB" "JIS_UNDERSCORE" "JIS_YEN" "JIS_EISUU" "JIS_KANA" "FN")
                      (mapcar (cut format "F%d" <>) (erfi:iota 19 1))))
    ("SPC" . "SPACE")
    ("ESC" . "ESCAPE")
    ("DEL" . "DELETE")
    ("\\" . "BACKSLASH")
    ("`"  . "BACKQUOTE")
    ("["  . "BRACKET_LEFT")
    ("]"  . "BRACKET_RIGHT")
    ,@(mapcar (lambda (str) (cons (concat "<" str ">") (concat "CURSOR_" (upcase str))))
              '("up" "down" "left" "right"))
    ;; Dvorak correspondence: ex: "(a)" -> "A", "(.)" -> "E", "(z)" -> "SLASH"
    ,@(append (erfi:map (lambda (x y) (cons (concat "(" x ")") (upcase y)))
                        (mapcar 'string (erfi:string->list "aoeuidhtn',.pyfgcrl;qjkxbm"))
                        (mapcar 'string (erfi:string->list "asdfghjklqwertyuiopzxcvbnm")))
              (mapcar (lambda (p) (cons (concat "(" (car p) ")") (cdr p)))
                      '(("s" . "SEMICOLON")
                        ("-" . "QUOTE")
                        ("MINUS" . "QUOTE")
                        ("/" . "BRACKET_LEFT")
                        ("=" . "BRACKET_RIGHT")
                        ("w" . "COMMA")
                        ("v" . "DOT")
                        ("z" . "SLASH")
                        ("[" . "MINUS")
                        ("]" . "EQUAL"))
                        ))
    ))



;;;
;;; Components
;;;

(defun gkc-key-to-key (key-sequence1 key-sequence2)
  (gkc-autogen (gkc:%key-to-key:aux "__KeyToKey__\n  " (list key-sequence1 key-sequence2))))

(defun gkc-key-overlaid-modifier (&rest key-sequence-list)
  (gkc-autogen (gkc:%key-to-key:aux "__KeyOverlaidModifier__\n  " key-sequence-list)))

(defun gkc:%key-to-key:aux (prefix key-sequence-list)
  (concat prefix (erfi:string-join (mapcar 'gkc:%key-sequence->string key-sequence-list) ",\n  ")))

(defun gkc:%key-sequence->string (ks)
  (if (and (listp ks) (eq 'raw (car ks)))
      (cadr ks)
      (let1 seq (erfi:string-split ks '(regexp " +"))
        (erfi:string-join (mapcar 'gkc:%parse-key-combination seq) ", "))))

(defun gkc:%parse-key-combination (key-combination)
  (let* ((kc (erfi:string-replace-regexp key-combination "--$" "-HYPHONE"))
         (ks (erfi:string-split kc "-"))
         (ks (mapcar (cut erfi:string-replace-regexp <> "^HYPHONE$" "-") ks)))
    (destructuring-bind (modifiers (key)) (erfi:split-at ks (- (length ks) 1))
      (let ((modifier-codes (mapcar 'gkc:%modifier-abbrev->modifier-code modifiers))
            (key-code (gkc:%key-string->key-code key)))
        (erfi:string-join `(,key-code ,@modifier-codes) ", ")))))

(defun gkc:%modifier-abbrev->modifier-code (modifier-abbrev)
  (if-let1 a (assoc modifier-abbrev gkc-meta-key-abbrev-string-alist)
    (erfi:$ erfi:string-join <> ", " $ mapcar (cut concat "ModifierFlag::" <>) (cdr a))
    (error "`%s`: Not supported meta key: %s" 'gkc:%modifier-abbrev->modifier-string modifier-abbrev)))

(defun gkc:%key-string->key-code (key-string)
  (concat "KeyCode::"
          (if-let1 a (assoc key-string gkc-key-string-key-code-alist)
            (cdr a)
            (if (let1 case-fold-search nil (string-match "^[a-z]$" key-string))
                (capitalize key-string)
                (error "`%s`: Not supported key: %s" 'gkc:%key-string->key-code key-string)))))



;;;
;;; Macros and elements
;;;


(defmacro gkc-define-elements (spec)
  `(eval-and-compile ,@(gkc-define-elements:elements spec)))

(defun gkc-define-elements:elements (spec)
  (if (null spec)
      '()
      `(,(gkc-define-elements:element (car spec)) ,@(gkc-define-elements:elements (cdr spec)))))

(defun gkc-define-elements:element (arg)
  (erfi:ecase (length arg)
    ((2)
     (let1 elt (car arg)
       `(defun ,(intern (concat "gkc-" elt)) (&rest args)
          (erfi:string-join (append (list (concat "<" ,elt ">")) args (list (concat "</" ,elt ">"))) ,(cadr arg)))))
    ((1)
     (gkc-define-element `(,(car arg) "")))))

(gkc-define-elements
 (("item" "\n")
  ("autogen" "\n")
  ("name" "")
  ("identifier" "")
  ("only" "")
  ("root" "\n\n")
  ("devicevendordef" "\n")
  ("vendorname" "")
  ("vendorid" "")
  ("deviceproductdef" "\n")
  ("productname" "")
  ("productid" "")
  ("appdef" "\n")
  ("appname" "")
  ("equal" "")
  ("device_only" "")
  ))

(defmacro gkc-progn-as (element &rest args)
  (declare (indent 1))
  `(,element ,@args))

(defmacro gkc-progn (&rest args)
  (declare (indent 0))
  `(gkc-item ,@args))

(defmacro gkc-define-item (identifier name &rest body)
  (declare (indent 2))
  `(gkc-item
    (gkc-name ,name)
    (gkc-identifier ,identifier)
    ,@body))

(defmacro gkc-recursive-only (specifier &rest body)
  (declare (indent 1))
  `(gkc-progn ,@(mapcar (cut gkc-recursive:aux (list 'gkc-only specifier) <>) body)))

(defun gkc-recursive:aux (specifier body)
  (erfi:case (car body)
    ((gkc-define-item)
     (destructuring-bind (init tail) (erfi:split-at body 3)
       `(,@init ,specifier ,@tail)))
    ((gkc-progn)
     `(gkc-recursive-only ,specifier ,@(cdr body)))
    (else
     body)))

(defun gkc-appendix (str)
  (let1 str (erfi:string-replace-regexp-all str "\\`\n*" "" "\n*\\'" "")
    (erfi:$ erfi:string-join <> "\n" $
            mapcar (cut format "<appendix><![CDATA[ %s ]]></appendix>" <>) $
            erfi:string-split str "\n")))



;;;
;;; Formatting
;;;


(defmacro gkc-format (&rest body)
  (declare (indent 0))
  `(with-temp-buffer
     (web-mode)
     (insert (concat ,@body))
     (erfi:dynamic-let ((web-mode-markup-indent-offset 2)
                        (indent-tabs-mode nil))
       (web-mode-buffer-indent))
     (let1 str (buffer-substring-no-properties (point-min) (point-max))
       (concat "<?xml version=\"1.0\"?>\n"
               (erfi:string-replace-regexp str "\n*\\'" "\n")))))


(provide 'generate-karabiner-config)
;;; generate-karabiner-config.el ends here
