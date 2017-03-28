#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include G_search.G_click.ahk
#include URL.ahk

global g_title,hwnd,g_class,g_class_exe,g_control

Gui, new_compiled:Add, ListBox, w280 h200 vMy_list_2, 
Gui, new_compiled:Add, Button, w280 h40 gdoit_actions Disabled vdoit_btn, Do it!
Gui, new_compiled:Add, Button, w280 h40 gpause_btn, `Pause/unpause
Gui, new_compiled:Add, Button, w280 h40 greload_btn, `Reload
gui, new_compiled:show,,Ndures Macro
chk_update()
process_load()
return

reload_btn:
Reload
return

pause_btn:
msgbox,일시정지/일시정지 해제
Pause
return

doit_actions:
doit_compiled_action()
return

new_compiledguiclose:
ExitApp

chk_update() {
GuiControl,new_compiled: , My_list_2, Checking : 확인중||
source:=ReadURL("https://drive.google.com/open?id=10ltWE3n7qquQ_kqjkUjaqUyfq8REKRiXemHdG6IXxok")
GuiControl,new_compiled: , My_list_2, Checking : 확인끝||
if(source="")
	return
RegExMatch(source,"meta property=""og:description"" content=\C(.*)\C><meta name=""google""",msg_a)
stringsplit,splited,msg_a,`|,`r
if(splited2="사용불가")
	{
		MsgBox, 0, 사용중지 안내, 개발자가 사용을 막았습니다., 20
		gui,new_compiled:destroy
		ExitApp
	}
else
	guicontrol,new_compiled:enable,doit_btn
}

process_load() {
iniread,g_title,%a_scriptdir%\process_info.ini,process_info,g_title
iniread,hwnd,%a_scriptdir%\process_info.ini,process_info,hwnd
iniread,g_class,%a_scriptdir%\process_info.ini,process_info,g_class
iniread,g_class_exe,%a_scriptdir%\process_info.ini,process_info,g_class_exe
iniread,g_control,%a_scriptdir%\process_info.ini,process_info,g_control

}

doit_compiled_action() {
