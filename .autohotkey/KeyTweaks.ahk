;;
;; This script tweaks Windows keyboard to my liking and habit:
;;
;;  CapsLock => LCtrl
;;  
;; Now as for bottom left corner of the keyboard, the keys on Dell Precision 3350 and Thinkpad are 
;;
;;  LCtrl, Fn, Win, Alt 
;;
;; I want that row to be as follows 
;; 
;;  Fn, Hyper, Alt, Win
;;
;; ** swapping fn and lctrl might be done only in BIOS or using hardware methods.
;; OS simply does not see Fn key
;; Swapping LAlt and LWin is done via SharpKeys otherwise there are some shortcuts that
;; are always intercepted by OS, e.g. Win-L
#SingleInstance

; It is hard to envision a need for a CapsLock. we will 
; remap CapsLock to LCtrl and RCtrl + CapsLock to CapsLock
>^CapsLock::CapsLock
CapsLock::LCtrl

;; LCtrl generates Hyper key

; 
; These settngs used to to be used back in a day to move between windows in Emacs on Windows
; 
$#Right::
IfWinActive ahk_class Emacs
	Send, ^!+{NumpadRight}
return
$#Left::
IfWinActive ahk_class Emacs
	Send, ^!+{NumpadLeft}
return
$#Up::
IfWinActive ahk_class Emacs
	Send, ^!+{NumpadUp}
return
$#Down::
IfWinActive ahk_class Emacs
	Send, ^!+{NumpadDown}
return
