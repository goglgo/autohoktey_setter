#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Gui,src_rec:Color, EEAA99
;~ Gui,src_rec:Font, S12, Arial Black
;~ Gui,src_rec:Add, button, BackgroundTrans w50 h200,123 ; vT1, 00:00:00
Gui,src_rec:Add, Text, BackgroundTrans w200 h200 ; vT1, 00:00:00

;;~ Gui, Add, Text, xp-3 yp-3 cFFB10F BackgroundTrans vT2, 00:00:00
;~ Gui,src_rec:+LastFound +ToolWindow +Resize +AlwaysOnTop +caption
;~ WinSet, TransColor, EEAA99
;~ ;Gui -border ;-Caption
;~ gui,src_rec:margin,10
;~ gui_id:=WinExist()
;~ Gui,src_rec:Show,w100 h100,Img_capture



;~ Gui,src_rec:Color, f0f0f0
;~ Gui, img_src: +LastFound
;~ img_src_ID := WinExist()
;~ gui,img_src: +lastfound resize
;~ Gui, img_src: Show, w800 h600, img_capture_tool

;~ Gui,capture_rec:Color, f0f0f0
;~ WinSet, TransColor, f0f0f0
;~ Gui, capture_rec: +LastFound +E0x00010000 +resize ;The ExStyle allows the parent to take focus if it's clicked.
;~ DllCall("SetParent", "uint", WinExist(), "uint", img_src_ID)
;~ Gui, capture_rec: Show, x5 y5 w200 h200, capturing_rec

;~ Gui, Main: New, +HwndmainGuiId +Resize, Main GUI
;~ Gui, Main: Show, w600 h150


;~ Gui, Child: New, +ParentMain +HwndchildGuiId1, Child GUI 1
;~ Gui, Child: Add, Text,,this is child gui
;~ Gui, Child: Show, x0 y0 w300 h100
;~ winset,trans,on,Child GUI 1

;~ Gui, Child: New, +ParentMain +HwndchildGuiId, ChildGUI
;~ Gui, Child: Add, Text,,this is child gui
;~ Gui, Child: Show, x0 y0 w200 h100


;~ Gui, Child2: New, +ParentMain +HwndchildGuiId, Child GUI 2
;~ Gui, Child2: Add, Text,,this is child gui
;~ Gui, Child2: Show, x100 y0 w200 h100,





;~ return

;~ f2::exitapp

;~ move:
;~ msgbox,1
;~ return

;~ img_srcguiclose:
;~ ExitApp

;~ capture_recguiclose:
;~ ExitApp

#Persistent
#SingleInstance
menu, tray, add ; separator
menu, tray, add, TestToggle&Check
menu, tray, add, TestToggleEnable
menu, tray, add, TestDefault
menu, tray, add, TestStandard
menu, tray, add, TestDelete
menu, tray, add, TestDeleteAll
menu, tray, add, TestRename
menu, tray, add, Test
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TestToggle&Check:
menu, tray, ToggleCheck, TestToggle&Check
menu, tray, Enable, TestToggleEnable ; Also enables the next test since it can't undo the disabling of itself.
menu, tray, add, TestDelete ; Similar to above.
return

TestToggleEnable:
menu, tray, ToggleEnable, TestToggleEnable
return

TestDefault:
if default = TestDefault
{
    menu, tray, NoDefault
    default =
}
else
{
    menu, tray, Default, TestDefault
    default = TestDefault
}
return

TestStandard:
if standard <> n
{
    menu, tray, NoStandard
    standard = n
}
else
{
    menu, tray, Standard
    standard = y
}
return

TestDelete:
menu, tray, delete, TestDelete
return

TestDeleteAll:
menu, tray, DeleteAll
return

TestRename:
if NewName <> renamed
{
    OldName = TestRename
    NewName = renamed
}
else
{
    OldName = renamed
    NewName = TestRename
}
menu, tray, rename, %OldName%, %NewName%
return

Test:
MsgBox, You selected "%A_ThisMenuItem%" in menu "%A_ThisMenu%".
return