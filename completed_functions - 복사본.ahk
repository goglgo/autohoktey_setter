get_active_program_info()
{
WinGetTitle, g_Title, A 			;g_title
WinActivate,%g_Title%
winget,hwnd,,%g_title%				;hwnd
WinGetClass,g_class,%g_title%		;g_class
	g_class=ahk_class %g_class%
WinGet, g_class_exe, ProcessName, A	;g_class_exe
	g_class_exe=ahk_exe %g_class_exe%	

ControlGetFocus, g_control, A  		;g_control, ClassNN얻어오기
modify_coord_capbordget()

return
}
modify_coord_capbordget()
{
SysGet, WindowCaptionHeight, 4 ; 캡션Height
SysGet, WindowBorderWidth, 32 ; 보더Width
SysGet, WindowBorderHeight, 33 ; 보더Height
}

init_function()
{
	img_name=
	Loop_factor=
	;~ if(if_factor!="")
		
	;~ if_factor=
	x_cor=
	y_cor=
	func_num=
	a_time:=0
	return
}

mouse_coord_add()
{
	mousegetpos,vx,vy
	MsgBox, 4, 진행 여부, `[x%vx%,y%vy%`]이것으로 진행합니까?
	ifmsgbox,yes
	{
		GuiControl, , My_list_2, 좌표 : x%vx%,y%vy% 설정||
		x_cor=%vx%
		y_cor=%vy%
		check_coord_add:=0
		;add_action()
		gui,getmouse:Destroy
		return true
	}
	else
	{
	;	gui,getmouse:Destroy
		return false
	}
}

DeleteAlt()  ; delete selected item
{
	gui,submit,nohide
    sendmessage,0x188,,,listbox1 ;, % title            ;선택한 리스트 번호
    LB_GETCURSEL := errorlevel+1
    controlget, getITEM, choice,, listbox1 ;, % title         ;선택한 리스트이름
    guicontrol,,EDT,% LB_GETCURSEL . "`," . getITEM
	sendmessage,0x182,LB_GETCURSEL-1,,listbox1, % title            ;선택리스트 삭제
return
}

img_load_copy()
	{
	FileSelectFile, SelectedFile, 3, , Open a file, imgs (*.png; *.bmp)
	if (SelectedFile = "")
		return
	SplitPath, SelectedFile, file_name,dir_path
	filecopy,%SelectedFile%,%A_workingdir%,1
	img_name=%file_name%
	msgbox,img : `[%file_name% `] get
}

count_total_actions(byref getCOUNT)
{
	sendmessage,0x18B,,,listbox1,Ndure      ;총 리스트수 구하기
    getCOUNT := errorlevel
	;msgbox,% getCOUNT
	return
}

save_actions_g()  ;;;temp
{
	;~ ControlGet, List, List,, Listbox1, A
	;~ Clipboard:=List
;~ msgbox %list%
ifexist,%a_scriptdir%\save_dat.txt
	FileDelete,%a_scriptdir%\save_dat.txt
count_total_actions(action_count)
num=1
txt=
doit_list_choice(num)
guicontrolget,txt_output,,my_list
txt_asd=%txt_output%
num++
action_count--
Loop,%action_count%
{
doit_list_choice(num)
guicontrolget,txt_output,,my_list
txt_asd=%txt_asd%`r`n%txt_output%

num++
}
;Clipboard:=txt_asd
;msgbox,%txt_asd%
fileappend,%txt_asd%,%A_scriptdir%\save_dat.txt,UTF-8
doit_list_choice(1)
msgbox, Saved!
return
}