;; -*- coding: utf-8; lexical-binding: t -*-

;; Usage: emacs --batch --eval '(push "~/git.keno/emacs/erfi/src" load-path)' --eval '(push "~/git.keno/emacs/erfi/src/new" load-path)' --eval '(push "'$(pwd)'" load-path)' --eval '(push "~/.emacs.d/el-get/web-mode" load-path)' -l _THIS_SCRIPT_


(require 'generate-karabiner-config)



;;;
;;; Configuration
;;;

(let1 str
    (gkc-format
      (gkc-progn-as gkc-root
        (gkc-progn-as gkc-devicevendordef
          (gkc-vendorname "PFU")
          (gkc-vendorid "0x04fe"))
        (gkc-progn-as gkc-deviceproductdef
          (gkc-productname "HHKProJP")
          (gkc-productid "0x000d"))

        (gkc-progn-as gkc-devicevendordef
          (gkc-vendorname "Topre_Corporation")
          (gkc-vendorid "0x0853"))
        (gkc-progn-as gkc-deviceproductdef
          (gkc-productname "Realforce_108UDK")
          (gkc-productid "0x011d"))

        (gkc-progn-as gkc-deviceproductdef
          (gkc-productname "APPLE_INTERNAL_KEYBOARD_TRACKPAD_0x0264")
          (gkc-productid "0x0264"))

        (gkc-progn-as gkc-appdef
          (gkc-appname "ADOBEREADER")
          (gkc-equal "com.adobe.Reader"))

        (gkc-progn
          (gkc-name "Fundamental keys and modifiers")

          (gkc-define-item "private.remap.exchange_backquote_backslash" "Exchange Backquote(`) and Backslash(\\)"
            )

          (gkc-define-item "private.remap.modifiers_common" "Modifiers for all"
            (gkc-appendix "
Backslash (left of Enter) => Escape,
Escape                    => Backquote,
Tab                       => Option_R (alt),
Shift_R                   => Tab,
")
            )

          (gkc-define-item "private.remap.modifiers_on_apple" "Modifiers on Apple's keyboard"
            (gkc-device_only "DeviceVendor::APPLE_COMPUTER,DeviceProduct::APPLE_INTERNAL_KEYBOARD_TRACKPAD_0x0264")
            (gkc-key-to-key "JIS_UNDERSCORE" "\\")
            (gkc-key-to-key "JIS_YEN" "`")
            (gkc-key-to-key "\\" "ESC")
            (gkc-key-to-key "ESC" "`")
            (gkc-key-to-key "TAB" "OPTION_R")
            (gkc-key-to-key "SHIFT_R" "TAB")
            (gkc-key-to-key "F19"       "c-OPTION_L")
            (gkc-key-to-key "OPTION_L"  "c-OPTION_L")
            (gkc-key-to-key "COMMAND_R" "C-<left>")
            (gkc-key-to-key "FN"        "C-<right>"))

          (gkc-define-item "private.remap.modifiers_on_hhk" "Modifiers on HHK (following the above setting)"
            (gkc-device_only "DeviceVendor::PFU, DeviceProduct::HHKProJP")
            (gkc-appendix "
Alt_R     => C-right
Option_L <=> Command_L
")
            (gkc-key-to-key "JIS_UNDERSCORE" "\\")
            (gkc-key-to-key "JIS_YEN" "`")
            (gkc-key-to-key "\\" "ESC")
            (gkc-key-to-key "ESC" "`")
            (gkc-key-to-key "TAB" "OPTION_R")
            (gkc-key-to-key "SHIFT_R" "TAB")
            (gkc-key-to-key "OPTION_R"  "C-<right>")
            (gkc-key-to-key "`"         "c-OPTION_L")
            (gkc-key-to-key "OPTION_L"  "COMMAND_L")
            (gkc-key-to-key "COMMAND_L" "OPTION_L"))

          (gkc-define-item "private.remap.modifiers_on_realforce" "Modifiers on Realforce (following the above setting)"
            (gkc-device_only "DeviceVendor::Topre_Corporation, DeviceProduct::Realforce_108UDK")
            (gkc-appendix "
Capslock (Control_R) =>  Control_L
Control_L            =>  Super
Windows              =>  Super
Command_R            =>  C-left
Option_R             =>  C-right
")
            (gkc-key-to-key "JIS_UNDERSCORE" "\\")
            (gkc-key-to-key "JIS_YEN" "`")
            (gkc-key-to-key "\\" "ESC")
            (gkc-key-to-key "ESC" "`")
            (gkc-key-to-key "TAB" "OPTION_R")
            (gkc-key-to-key "SHIFT_R" "TAB")
            (gkc-key-to-key "CONTROL_L" "c-OPTION_L")
            (gkc-key-to-key "COMMAND_L" "c-OPTION_L")
            (gkc-key-to-key "CONTROL_R" "CONTROL_L")
            (gkc-key-to-key "COMMAND_R" "C-<left>")
            (gkc-key-to-key "OPTION_R"  "C-<right>"))

          (gkc-define-item "private.remap.smart_eisuu_kana" "Smart Eisuu and Kana"
            (gkc-device_only "DeviceVendor::APPLE_COMPUTER,DeviceProduct::APPLE_INTERNAL_KEYBOARD_TRACKPAD_0x0264")
            (gkc-appendix "
JIS_EISUU => Muhenkan
JIS_KANA  => Henkan (Control_R; hyper)
Muhenkan + Space => JIS_EISUU
Muhenkan + Henkan => JIS_KANA
See also below SandS
")
            (gkc-key-to-key "JIS_EISUU"  "COMMAND_L")
            (gkc-key-to-key "c-SPC"      "JIS_EISUU")
            (gkc-key-to-key "c-JIS_KANA" "JIS_KANA"))
          (gkc-define-item "private.remap.smart_eisuu_kana.hhkb" "Smart Eisuu and Kana on HHKB"
            (gkc-device_only "DeviceVendor::PFU, DeviceProduct::HHKProJP")
            (gkc-appendix "
JIS_EISUU => Muhenkan
JIS_KANA  => Henkan (Control_R; hyper)
Muhenkan + Space => JIS_EISUU
Muhenkan + Henkan => JIS_KANA
See also below SandS
")
            (gkc-key-to-key "JIS_EISUU"  "COMMAND_L")
            (gkc-key-to-key "c-SPC"      "JIS_EISUU")
            (gkc-key-to-key "c-JIS_KANA" "JIS_KANA"))


          (gkc-define-item "remap.sands2kana" "SandS v2 on the right hand's sum position"
            (gkc-device_only "DeviceVendor::APPLE_COMPUTER,DeviceProduct::APPLE_INTERNAL_KEYBOARD_TRACKPAD_0x0264")
            (gkc-appendix "
* Change the Kana key (below \"M\") to the left shift key.
* Send a Yen key event when the Kana key is pressed alone.

* Send a Yen key event when the space key is released before another key is released.
For example:
  Kana down -> Kana up -> T down -> T up => Yen,T
  Kana down -> T down -> T up => Shift+T
  Kana down -> T down -> Kana up => Yen,T
")
            (gkc-key-overlaid-modifier "JIS_KANA" "SANDS2-SHIFT_L" "\\"))
          (gkc-define-item "remap.sands2kana.hhkb" "SandS v2 on the right hand's sum position on HHKB"
            (gkc-device_only "DeviceVendor::PFU, DeviceProduct::HHKProJP")
            (gkc-appendix "
* Change the Kana key (below \"M\") to the left shift key.
* Send a Yen key event when the Kana key is pressed alone.

* Send a Yen key event when the space key is released before another key is released.
For example:
  Kana down -> Kana up -> T down -> T up => Yen,T
  Kana down -> T down -> T up => Shift+T
  Kana down -> T down -> Kana up => Yen,T
")
            (gkc-key-overlaid-modifier "JIS_KANA" "SANDS2-SHIFT_L" "\\"))
          )

        (gkc-progn
          (gkc-name "C-h as backspace")

          (gkc-define-item "private.remap.c_h_as_backspace" "C-h as backspace"
            (gkc-key-to-key "C-(h)" "DEL"))
          )

        (gkc-progn
          (gkc-name "Fundamental key combinations")

          (gkc-define-item "private.remap.xmonad_like_keybindings" "XMonad like keybindings"
            (gkc-appendix "
Super+d => C-left
Super+n => C-right
Super+o => C-left
Super+i => C-right
Super+Space => C-up
Super+/ => C-tab
")
            (gkc-key-to-key "S-(d)" "C-<left>")
            (gkc-key-to-key "S-(n)" "C-<right>")
            (gkc-key-to-key "S-(o)" "C-<left>")
            (gkc-key-to-key "S-(i)" "C-<right>")
            (gkc-key-to-key "S-SPC" "C-<up>")
            (gkc-key-to-key "S-(/)" "c-TAB"))

          (gkc-define-item "private.remap.kill_app" "Kill app"
            (gkc-appendix "
Super-q => Command-q (kill app)
Super-k => Command-w (kill window)
")
            (gkc-key-to-key "S-(q)"   "c-(q)")
            (gkc-key-to-key "S-(j)"   "c-(c)")
            (gkc-key-to-key "S-(k)"   "c-(v)")
            (gkc-key-to-key "S-(')"   "c-(w)")
            (gkc-key-to-key "S-s-(')" "c-(q)"))
          )

        ;; comment out
        (gkc-define-item "private.remap.kill_window_on_finder" "Kill window on Finder"
          (gkc-appendix "Super-q -> Command-w (kill window)")
          (gkc-only "FINDER")
          (gkc-key-to-key "S-(q)" "c-(w)"))

        ;; comment out
        (gkc-define-item "private.cycle_app_in_the_current_space" "Cycle app in the current Space with super+t / super+h"
          (gkc-key-to-key "S-(t)" "C-F4"))

        (gkc-define-item "private.unix_like_copy" "Selecting text by dragging copies it to clipboard"
          (gkc-key-to-key '(raw "PointingButton::LEFT")
                          '(raw "PointingButton::LEFT,  KeyCode::I, ModifierFlag::COMMAND_L, Option::NOREPEAT")))

        ;; comment out
        (gkc-define-item "private.remap.reverse_mouse_scrolling" "Reverse scroll wheel on Logicool M570 trackball"
          (gkc-device_only "DeviceVendor::LOGITECH, DeviceProduct::LOGITECH_UNIFYING_0xc52b")
          (gkc-autogen "__FlipScrollWheel__ Option::FLIPSCROLLWHEEL_VERTICAL"))

        (gkc-define-item "private.remap.mouse_button_4_5" "Mouse button 4,5 to C-left and C-right"
          (gkc-key-to-key '(raw "PointingButton::BUTTON4") "C-<left>")
          (gkc-key-to-key '(raw "PointingButton::BUTTON5") "C-<right>"))

        (gkc-define-item "private.remap.dhtn_move_for_cocoa" "dhtn move for Cocoa"
          (gkc-only "PREVIEW")
          (gkc-key-to-key "(h)" "<up> <up> <up>")
          (gkc-key-to-key "(t)" "<down> <down> <down>")
          (gkc-key-to-key "(e)" "<up> <up> <up>")
          (gkc-key-to-key "(u)" "<down> <down> <down>"))

        (gkc-recursive-only "EXCEL"
          (gkc-name "Excel")
          (gkc-define-item "private.remap.app_excel_c_h_to_delete" "Change C-h to backspace"
            (gkc-key-to-key "C-(h)" "DEL"))
          (gkc-define-item "private.remap.app_excel_c_f_to_forward" "Change C-f to forward"
            (gkc-key-to-key "C-(f)" "<right>"))
          (gkc-define-item "private.remap.app_excel_c_b_to_backward" "Change C-b to backword"
            (gkc-key-to-key "C-(b)" "<left>"))
          )

        (gkc-recursive-only "Slack"
          (gkc-name "Slack")

          (gkc-define-item "private.remap.slack.ht-as-previous-next-channel" "Change M-h/M-t to previous/next channel"
            (gkc-key-to-key "or-(h)" "o-<up>")
            (gkc-key-to-key "or-(t)" "o-<down>"))

          (gkc-define-item "private.remap.slack.mw-as-previous-next-unread-channel" "Change M-m/M-w to previous/next unread channel"
            (gkc-key-to-key "or-(m)" "o-s-<up>")
            (gkc-key-to-key "or-(w)" "o-s-<down>")
            (gkc-key-to-key "c-(m)" "o-s-<up>")
            (gkc-key-to-key "c-(w)" "o-s-<down>"))

          (gkc-define-item "private.remap.slack.eu-as-previous-next-unread-channel" "Change M-e/M-u to previous/next unread channel"
            (gkc-key-to-key "or-(e)" "o-s-<up>")
            (gkc-key-to-key "or-(u)" "o-s-<down>")
            (gkc-key-to-key "c-(e)" "o-s-<up>")
            (gkc-key-to-key "c-(u)" "o-s-<down>"))

          (gkc-define-item "private.remap.slack.dn-as-previous-next-team-old" "Change M-d/M-n to previous/next team"
            (gkc-key-to-key "or-(d)" "C-s-TAB")
            (gkc-key-to-key "or-(n)" "C-TAB"))

          (gkc-define-item "private.remap.slack.dn-as-previous-next-team" "Change Command-d/Command-n to previous/next team"
            (gkc-key-to-key "c-(d)" "C-s-TAB")
            (gkc-key-to-key "c-(n)" "C-TAB"))

          (gkc-define-item "private.remap.slack.oi-as-previous-next-team-old" "Change Command-o/Command-i to previous/next team"
            (gkc-key-to-key "c-(o)" "C-s-TAB")
            (gkc-key-to-key "c-(i)" "C-TAB"))

          (gkc-define-item "private.remap.slack.commpa-period-as-previous-next-team-in-history" "Change Command-,/Command-. to previous/next channel in history"
            (gkc-key-to-key "c-(,)" "c-([)")
            (gkc-key-to-key "c-(.)" "c-(])"))

          (gkc-define-item "private.remap.slack.s-as-prompt-channel" "Change Command-s to change channel with prompt"
            (gkc-key-to-key "c-(s)" "c-(t)"))
          )

        (gkc-recursive-only "GOOGLE_CHROME"
          (gkc-name "Chrome")

          (gkc-define-item "private.remap.chrome_command_dn_to_prevnext_window" "Command+d/n to previous/next window"
            (gkc-key-to-key "c-(d)" "C-s-TAB")
            (gkc-key-to-key "c-(n)" "C-TAB"))
          )

        (gkc-recursive-only "Chromium"
          (gkc-name "Chromium")

          (gkc-define-item "private.remap.chromium_command_dn_to_prevnext_window" "Command+d/n to previous/next window"
            (gkc-key-to-key "c-(d)" "C-s-TAB")
            (gkc-key-to-key "c-(n)" "C-TAB"))
          )

        (gkc-recursive-only "TERMINAL"
          (gkc-name "Terminal")

          (gkc-define-item "private.remap.terminal_command_dhtn_to_control_t_control_dhtn" "Command+d/h/t/n to C-t C-d/h/t/n"
            (gkc-key-to-key "c-(d)" "C-(t) C-(d)")
            (gkc-key-to-key "c-(h)" "C-(t) C-(h)")
            (gkc-key-to-key "c-(t)" "C-(t) C-(t)")
            (gkc-key-to-key "c-(n)" "C-(t) C-(n)"))
          )
        ))
  (princ str))
