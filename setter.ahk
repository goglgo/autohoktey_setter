﻿/*
될랑가모르겠지만 F8 고치는건 https://autohotkey.com/docs/commands/Gui.htm#AltSubmit


픽셀서치도 그냥 IF한거에 넣자..새로 만드려니 너무 힘이 들거같다.

*/

current_version=0.1.170324.1

coordmode,mouse,client
global Action_1
global g_Title,hwnd,g_class,g_class_exe,g_control,Process_info_text, current_version
global combined_naming,current_If_w_name,if_count,loop_factor ;,global_if_count ;,previous_a_gui,current_a_gui,idntknow,iflistarray
previous_a_gui:=1
if_count:=1
loop_factor:=1

action_naming=좌표 클릭|이미지 기다림 클릭|이미지 있을 시 클릭|이미지 정밀서치클릭|Sleeping|Loop(루프 시작)|Loop end(루프 끝) ;|If(조건문)|End if(조건문 끝)
action_naming_2=IF(이미지 서치)[참]|IF(이미지 서치)[거짓]|IF(픽셀서치)[참]|IF(픽셀서치)[거짓]|
combined_naming=% action_naming . "`|" . action_naming_2
current_If_w_name=asd

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
ifnotexist,%A_scriptdir%\imgs
	FileCreateDir,%a_scriptdir%\imgs
SetWorkingDir %A_ScriptDir%\imgs  ; Ensures a consistent starting directory.

;~ #include 7zip.ahk
;~ #include G_search.G_click.ahk
;~ #include completed_functions.ahk

#include <7zip>
#include <G_search.G_click>
#include <URL>

{
;~ -------------------gui
Gui, Add, ListBox, x12 y29 w280 h200 vMy_list gLBevent, 
Gui, Add, ListBox, x12 y229 w280 h200 vMy_list_2, 
Gui, Add, Button, x562 y49 w110 h20 gadd_actions vadd_btn, ADD
Gui, Add, Button, w110 h20 gdel_action Disabled vdel_btn, Delete
Gui, Add, Button, w110 h20 gsave_actions Disabled vsave_btn, Save
Gui, Add, Button, w110 h20 gLoad_saved_dat_g vload_btn, Load
Gui, Add, Button, w110 h20 gReload_script vreload_btn, 초기화
Gui, Add, Button, hp wp vpause_btn Disabled g_pause, `Pause/Unpause
Gui, Add, Button, w110 h40 gdoit_actions Disabled vdoit_btn, Do it!
Gui, Add, Button, w110 h40 vimgcapture_btn Disabled, 이미지 캡쳐`n도우미
Gui, Add, Button, w110 h40 vaction_to_exe_btn Disabled gcompile_action, Action 컴파일
Gui, Add, DropDownList, x302 y49 w200 h200 vAction_1 gdropdown_1 ,%combined_naming%
Gui, Add, Text,w200 h90 vadd_status vStatus_translate, ADD_status  ;;해석용
Gui, Add, button,w25 h25 gup_dowwn_btn vitemUP , ▲  
Gui, Add, button,w25 h25 gup_dowwn_btn vitemDN , ▼  
Gui, Add, Button, x572 y-1 w100 h30 gopen_process_select_gui , 프로세스 선택
Gui, Add, Text, x302 y9 w260 h40 vMain_process_text , Process_select

; Generated using SmartGUI Creator for SciTE
Gui, Show, w687 h480,Ndure
}
;~ disabling_btns()

chk_update()

return


compile_action:
compile_all_line()
return

up_dowwn_btn:
gui,%a_gui%:submit,NoHide
if(my_list="")
	return
up_or_down()
return
up_or_down() {
	gui,%a_gui%:submit,nohide
	WinGetActiveTitle,title
	guicontrolget,My_list,%a_gui%:,My_list
    sendmessage,0x18B,,,listbox1, % title        ;총 줄수
    LB_GETCOUNT := errorlevel
    sendmessage,0x188,,,listbox1, % title            ;선택리스트 번호 얻기
    ifequal,a_guicontrol,itemUP,ifequal,errorlevel,0,return
    ifequal,a_guicontrol,itemDN,ifequal,errorlevel,% LB_GETCOUNT-1,return
    LB_GETCURSEL := errorlevel
	
    sendmessage,0x182,LB_GETCURSEL,,listbox1, % title            ; 리스트 삭제
    sendmessage,0x181,LB_GETCURSEL + (a_guicontrol="itemDN" ? 1:-1),"" . My_list, listbox1, % title    ;추가
    sendmessage,0x186,LB_GETCURSEL + (a_guicontrol="itemDN" ? 1:-1),,listbox1, % title    ;선택
}


Reload_script:
reload

_pause:
msgbox, !!
pause
return


LBevent:
if(a_guievent="doubleclick")	{
	gui_na:=% a_gui . ":"
	doit_line(a_eventinfo,gui_na) ;;;temp
}
gui,%a_gui%:submit,nohide
a:=translate_action(my_list)
guicontrol,%a_gui%:,Status_translate,%a%

return



dropdown_1:

if(a_gui!=1) {
	gui_na:=% a_gui . ":"
	gui,%gui_na%submit,nohide
}
else
	gui,submit,nohide

adding_action(Action_1,gui_na)
enabling_btns()
return

open_process_select_gui:
ifwinnotexist,Select_process
	oepn_process_gui()
enabling_btns()
return
Load_saved_dat_g:

guicontrol,disable,load_btn
saved_data_all_load()
guicontrol,enable,load_btn
enabling_btns()
return

del_action:
DeleteAlt(a_gui)  ; delete selected item
return

save_actions:
{
gui,submit,nohide
guicontrolget,line_output,1:,My_list
if(line_output="")
{
	msgbox, 저장할 것이 없습니다
	return
}
guicontrol,disable,save_btn
save_all_line()
guicontrol,Enable,save_btn
return
}


doit_actions:
{
guicontrol,disable,doit_btn
doit_all_actions()
guicontrol,disable,doit_btn
}
return

f7::Reload

add_actions:
msgbox,준비중

return


doit_line(num,gui_no="1:") ;;;temp
{
	
	;;좌표 클릭|이미지 기다림 클릭|이미지 있을 시 클릭|이미지 정밀서치클릭|Sleeping|Loop(루프 시작)|Loop end(루프 끝)|If(조건문)|End if(조건문 끝)
	;~ sleep,%entire_sleep%
	if(gui_no=" " or gui_no="")
		gui_no:="1:"
	gui,%gui_no%submit,nohide
	GuiControl,%gui_no%Choose, My_list,%num%
	guicontrolget,line_output,%gui_no%,My_list
	Data_split(line_output,func_num,img_name,x_cor,y_cor,Loop_factor,if_factor)
	
	if(func_num="")
		return
	if(func_num=1) ; 좌표클릭
		{
		postmessage_click(x_cor,y_cor)
		GuiControl, , My_list_2, Clicked : `[ %x_cor%`,%y_cor%`]||
		return
	}
	if(func_num=2) ; 이미지 기다림 클릭
	{
		GuiControl, , My_list_2, 이미지`[%img_name%`]이 나오길 기다리는 중`(최대1분`)||
		postmessage_img_wait_click(img_name)
		
		return
	}
	if(func_num=3) ; 이미지 있을 시 클릭
	{
		if(postmessage_img_click(img_name)=false)
			{
			GuiControl, , My_list_2, 이미지`[%img_name%`] 찾을 수 없음||
			return
			}
		else
		{
			
			GuiControl, , My_list_2, 이미지`[%img_name%`] 찾음||
			postmessage_img_click(img_name)
			
		}
	}

	;~ if(func_num=4) ; 이미지 정밀서치 클릭
		;~ find_img_trans_loop(img_name)
	if(func_num=5) ;sleep
	{
		all_sleep(img_name)
	}
	;~ if(func_num=6) ; 루프시작
		;~ msgbox,준비중
	;~ if(func_num=7) ; 루프 끝
		;~ msgbox,준비중
	if(func_num=8) ;If 이미지서치 참
	{   ;;;if_factor= 창이름, y_cor = IF1:
		;~ if(a_thislabel="LBevent")
			;~ gui,%y_cor%show
		if(gsearch(img_name)=true)
		{	
			gui,%y_cor%show
			num:=1
			a:=chk_total_count(if_factor)
			if(a_thislabel!="LBevent")
			loop,%a%
			{
				doit_line(num,y_cor) ;;;temp
				num++
			}
			
			;~ gui,%y_cor%hide
		}
		if(gsearch(img_name)=false)
		{
			GuiControl, , My_list_2, 이미지`[%img_name%`] 찾을 수 없음||
		}
		;~ if(x_cor!=1)
			;~ gui,%x_cor%hide
			
	}
	;~ if(func_num=9) ;If 이미지서치 거짓
		;~ msgbox,준비중

	return
}


all_sleep(sleep_time)
{
	GuiControl, , My_list_2, Sleeping : `[%sleep_time%`]||
	sleep,%sleep_time%
	GuiControl, , My_list_2, End `Sleep||
	return
}

write_process_info()
{
iniwrite,%g_title%,%a_scriptdir%\process_info.ini,process_info,g_title
iniwrite,%hwnd%,%a_scriptdir%\process_info.ini,process_info,hwnd
iniwrite,%g_class%,%a_scriptdir%\process_info.ini,process_info,g_class
iniwrite,%g_class_exe%,%a_scriptdir%\process_info.ini,process_info,g_class_exe
iniwrite,%g_control%,%a_scriptdir%\process_info.ini,process_info,g_control
}



current_if_save(gui_no,target)
{
num:=1
a:=chk_total_count("")
combined_list:=""

loop,%a%
{
	GuiControl,%gui_no%Choose, My_list,%num%
	;~ sleep,100
	guicontrolget,choose_list,%gui_no%,My_list
	combined_list=% combined_list . "|" . choose_list
	
	num++
}
stringreplace,combined_list,combined_list,`|,
inidelete,%a_scriptdir%\command_list.ini,%target%,%gui_no%
iniwrite,%combined_list%,%a_scriptdir%\command_list.ini,%target%,%gui_no%
;~ iniread,outputvar,filename,section,key
;~ msgbox,%combined_list%
gui,%gui_no%Hide
	
return
}




guiclose:
ExitApp

;~ f2::ExitApp






oepn_process_gui() {
ifwinexist,Select_process
{
	settimer,get_realtime_program_info,off
	gui,Processinfo:Destroy
}
ifwinnotexist,Select_process
{	
	settimer,get_realtime_program_info,100
	wingetpos,nx,ny,nw,nh,Ndure
	nx:=nx-210
	Gui,Processinfo:Add, Text, x12 y9 w170 h150 vProcess_info_text , F8
	Gui, Processinfo:Show,x%nx% y%ny% w205 h180,Select_process
	return
}

}

get_realtime_program_info:
{
	IfWinnotExist,Select_process
		{
			settimer,get_realtime_program_info,off
			gui,Processinfo:Destroy
			return
	}
	get_active_program_info()
	GuiControl, Processinfo: , Process_info_text , Title : %g_Title% `n`nHWND : %hwnd%`n`nClass : %g_class%`n`nClass_exe : %g_class_exe%`n`nClassNN : %g_control%`n[[F8로 설정]]
	
	return
}

get_active_program_info()
{
IfWinExist,Select_process
{
WinGetTitle, g_Title, A 			;g_title
WinActivate,%g_Title%
winget,hwnd,,%g_title%				;hwnd
WinGetClass,g_class,%g_title%		;g_class
	g_class=ahk_class %g_class%
WinGet, g_class_exe, ProcessName, A	;g_class_exe
	g_class_exe=ahk_exe %g_class_exe%	

ControlGetFocus, g_control, A  		;g_control, ClassNN얻어오기
;~ modify_coord_capbordget()
}
return
}

adding_action(input_action,gui_no="")
{
	func_num:=get_func_num(input_action) ;Action_1
	adding_action_selected(func_num,gui_no)
	return
}

adding_action_selected(num,gui_no="")
{

	;~ msgbox,% gui_no . "adding_actions"
	if(num=1)
	{
		getting_mouse_pos()
		mouse_coord_add(x_cor,y_cor)
		if(x_cor="" or y_cor="")
			return
		;~ msgbox,% x_cor . y_cor
		add_action(1,,x_cor,y_cor,,,gui_no)
		return
	}
	if(num=2 or num=3 or num=4 or num=8) 					;;;이미지 클릭 시리즈
		{
		img_name:=img_load_copy()
		if(img_name="")
			return
		if(num!=8)
			add_action(num,img_name)
	}
	if(num=5)
		sleep_a_time()
	if(num=8)
	{
		inputbox,w_name,조건의 이름을 적어주세요,조건의 이름은 무엇입니까?
		if(errorlevel=1)
			return
		if(w_name="")
			return
		gui_no:="IF" . if_count . ":"
		if_count++
		open_new_gui(gui_no,w_name)
		add_action(8,img_name,a_gui,gui_no,,w_name)
		
	}
	
	return
}



open_new_gui(gui_no,w_name="")
{ ;vStatus_translate
	gui, %gui_no%Destroy
	Gui, %gui_no%Add, ListBox, w280 h200 vMy_list gLBevent,
	Gui, %gui_no%Add, DropDownList, w280 h200 gdropdown_1 vAction_1,%combined_naming%
	Gui, %gui_no%Add, Text,		w280 h80 vStatus_translate, Status
	Gui, %gui_no%Add, Button,	w280 h25 gdel_action			, DELETE
	Gui, %gui_no%Add, button,	w280 h25 gup_dowwn_btn vitemUP 	, ▲
	Gui, %gui_no%Add, button,	w280 h25 gup_dowwn_btn vitemDN 	, ▼  
	gui, %gui_no%show,,%w_name%
	return
}

chk_factors(gui_no="",w_title="") ;;gui_no exam> 2:, selectprocess::
{
	num:=1
	a:=chk_total_count(w_title)
	loop,%a%
	{
	GuiControl,%gui_no%Choose, My_list,%num%
	;~ sleep,10
	guicontrolget,choose_list,%gui_no%,My_list
	
	Data_split(choose_list,func_num,img_name,x_cor,y_cor,Loop_factor,if_factor)
	num++
	if(if_factor!="")
		if_count++
	if(loop_factor!="")
		loop_factor++
	}
}



Data_split(line_output,byref func_num="",byref img_name="",byref x_cor="",byref y_cor="" ,byref Loop_factor="",byref if_factor="")
{
	StringSplit, data_one, line_output, `,
	func_num:=data_one1, 	img_name:=data_one2, 	x_cor:=data_one3, 	y_cor:=data_one4, 	Loop_factor:=data_one5, 	if_factor:=data_one6
	return
}

getmouseguiclose:
settimer,
gui,getmouse:Destroy
return



chk_total_count(Main_gui_title="Ndure")
{
	sendmessage,0x18B,,,ListBox1,%Main_gui_title% ;%Main_gui_title%      ;총 리스트수 구하기
	get:=errorlevel
	return get
}

getting_mouse_pos()
{
start := A_TickCount
static coord_xy
ifwinexist,Mouse position
	{
		gui,getmouse:Destroy
		return
	}
ifwinnotexist,Mouse position
	{
		
		wingetpos,nx,ny,nw,nh,Ndure
		nx:=nx-125
		Gui getmouse:Add, text, w100 h100 vcoord_xy,[[활성창 기준]]`n[F8]로 설정`nX 좌표 :`n`n`nY 좌표 :`n`nF8로 설정
		gui getmouse:show,x%nx% y%ny% ,Mouse position
		#ifwinexist,Mouse position
		loop
		{
			
			sleep,80
			MouseGetPos,ovx,ovy
			GuiControl,getmouse:, coord_xy,[[활성창 기준]]`n`nX 좌표 :%ovx%`n`n`nY 좌표 :%ovy%`n`nF8로 설정
			ifwinnotexist,Mouse position
			{
				#ifwinexist
				gui,getmouse:Destroy
				return
			}
			if(A_TickCount-start >= 20000)
				gui,getmouse:Destroy
		}
	}
	
}

add_action(func_num,img_name="",x_cor="",y_cor="",Loop_factor="",if_factor="",gui_no="")
{
	if(gui_no=1)
		gui_no="1:"
	a=%func_num%,%img_name%,%x_cor%,%y_cor%,%Loop_factor%,%if_factor%
	GuiControl,%gui_no%, My_list,%a%||
return
}

get_func_num(input_action_name) ;; func_num:=get_func_num(action_naming,Action_1)
{
	num_a:=1
	StringSplit, data_one, combined_naming, `|
	Loop
	{
		if(data_one%num_a%="" && data_one%num_a%=input_action_name)
		{
			msgbox,% data_one%num_a% . func_num . "[불일치 에러]"
			break
		}
		if(input_action_name=data_one%num_a%)
			{
				func_num=%num_a%
				return func_num
			}
				num_a++
	}
}


#ifwinexist,Select_process
{
	f8::
	{
		get_active_program_info()
		GuiControl, processinfo: , Process_info_text , Title : %g_Title% `n`nHWND : %hwnd%`n`nClass : %g_class%`n`nClass_exe : %g_class_exe%`n`nClassNN : %g_control%
		MsgBox, 4, 진행 여부, `[%g_title%`]이것으로 진행합니까?
			ifmsgbox,yes
			{
				Gui, processinfo:destroy
				guicontrol,,Main_process_text,`[%g_title%`]
				GuiControl, , My_list_2, 프로세스 선택 : `[%g_title%`]||
				#IfWinExist
				return
			}
		ifmsgbox,no
			msgbox,아니오를 누르셨습니다.
		#IfWinExist
	return
	}
}

#ifwinexist,Mouse position
{
f8::

gui,getmouse:Destroy
#ifwinexist
return
}

mouse_coord_add(byref x_cor,byref y_cor)
{
	
	mousegetpos,vx,vy
	MsgBox, 4, 진행 여부, `[x%vx%,y%vy%`]이것으로 진행합니까?
	ifmsgbox,yes
	{
		GuiControl, , My_list_2, 좌표 : x%vx%,y%vy% 설정||
		x_cor=%vx%
		y_cor=%vy%
		return true
	}
	else
	{
		return false
	}
}

img_load_copy()
	{
	setworkingdir,%a_scriptdir%\imgs
	FileSelectFile, SelectedFile, 3, , Open a file, imgs (*.png; *.bmp;*.gif)
	if (SelectedFile = "")
		return
	SplitPath, SelectedFile, file_name,dir_path
	filecopy,%SelectedFile%,%A_workingdir%,1
	GuiControl, , My_list_2, `[%file_name% `] copied and added||
	MsgBox, 0, Work done!, img : `[%file_name% `] copied, 1
	
	return file_name
}

sleep_a_time()
{
	sleep_time:=input_sleep_time()
	if(sleep_time=false)
		return
	add_action(5,sleep_time)
	GuiControl, , My_list_2, `[%sleep_time% `] ms 슬립 설정||
	return
	}
	
	input_sleep_time() ;sleep_time:=input_sleep_time()
{
	InputBox sleep_time
	if sleep_time is not integer
	{
		sleep_time:=0
		MsgBox, 숫자를 입력해 주세요.
		return false
	}
	return sleep_time
}

doit_all_actions() {
a:=chk_total_count("Ndure")
	num:=1
	a_count_Mylist2:=0
loop
	{
	loop,%a%
	{
	doit_line(num,gui_no)
	num++
	a_count_Mylist2++
	;GuiControl, , Status_translate,%a_count_Mylist2% ;;;;현재 리스트박스를 해석해서 보여줌
	if(a_count_Mylist2>200)
		{
		a_count_Mylist2:=0
		GuiControl, , My_list_2,|
		GuiControl, , My_list_2, `[로그 초기화`]||
		}
	}
num:=1
	}
}

compile_all_line() {
	a:=chk_total_count("Ndure")
	num:=1
	
		
	
	ifexist,%a_scriptdir%\temp_c
		fileremovedir,%a_scriptdir%\temp_c
	ifexist,%a_scriptdir%\img_list.txt
		filedelete,%a_scriptdir%\img_list.txt
	ifexist,%a_scriptdir%\functions.txt
		FileDelete,%a_scriptdir%\functions.txt
	ifexist,%a_scriptdir%\process_info.ini
		filedelete,%a_scriptdir%\process_info.ini
	FileCreateDir,%a_scriptdir%\temp_c
	FileCreateDir,%a_scriptdir%\temp_c\imgs
	ifnotexist,%a_scriptdir%\temp_c\gdip_v2.ahk
		filecopy,%a_scriptdir%\gdip_v2.ahk,%a_scriptdir%\temp_c\gdip_v2.ahk
	ifnotexist,%a_scriptdir%\temp_c\G_search.G_click.ahk
		filecopy,%a_scriptdir%\G_search.G_click.ahk,%a_scriptdir%\temp_c\G_search.G_click.ahk
	ifnotexist,%a_scriptdir%\temp_c\gdip_imagesearch.ahk
		filecopy,%a_scriptdir%\gdip_imagesearch.ahk,%a_scriptdir%\temp_c\gdip_imagesearch.ahk
	ifnotexist,%a_scriptdir%\temp_c\URL.ahk
		filecopy,%a_scriptdir%\URL.ahk,%a_scriptdir%\temp_c\URL.ahk
	
	
	compile_gui_include_etc()
	write_process_info()
	
	Loop,%a%
	{
		compile_one_line(num,gui_no)
		num++
	}
	
	fileappend,`n`},%a_scriptdir%\functions.txt,UTF-8
	IniRead,d,%a_scriptdir%\img_list.txt,Used_img_list
	sort,d,u
	filedelete,%a_scriptdir%\img_list.txt
	iniwrite,%d%,%a_scriptdir%\img_list.txt,Used_img_list
	
	filecopy,%a_scriptdir%\process_info.ini,%a_scriptdir%\temp_c
	
	adrs=% a_scriptdir . "\imgs\"
	
	loop,parse,d,`n,`r
	{
		N_adrs=% adrs . A_LoopField
		filecopy,%N_adrs%,%a_scriptdir%\temp_c\imgs,1
		ifnotexist,%N_adrs%
		{
			Loop
			{
				sleep,20
				ifexist,%N_adrs%
					break
			}
		}
		GuiControl,1:, My_list_2, Saved Imgs : `[ %a_loopfield%`]||
	}
	filecopy,%a_scriptdir%\functions.txt,%a_scriptdir%\temp_c\Ndure.ahk
	filedelete,%a_scriptdir%\functions.txt
	filedelete,%a_scriptdir%\img_list.txt
	sleep,100
	runwait,%comspec% /c %a_scriptdir%\Compiler\ahk2exe.exe /in %a_scriptdir%\temp_c\Ndure.ahk
	GuiControl,1:, My_list_2,`[ 컴파일 완료! `]||
	filedelete,%a_scriptdir%\functions.txt
	run,%a_scriptdir%\temp_c
	MsgBox, 262208, 완료!, 컴파일이 완료되었습니다.!
}






compile_one_line(num,gui_no="1:") {
	gui,%gui_no%submit,NoHide
	
	guicontrol,%gui_no%choose,My_list,%num%
	guicontrolget,line_output,%gui_no%,My_list
	Data_split(line_output,func_num,img_name,x_cor,y_cor,Loop_factor,if_factor)
	
	if(func_num=2 or func_num=3 or func_num=4  or func_num=8 or func_num=9)
		iniwrite,%img_name%,%a_scriptdir%\img_list.txt,Used_img_list
	
	if(func_num=1)
		a=`npostmessage_click(%x_cor%,%y_cor%)
	if(func_num=2)
		a=`npostmessage_img_wait_click(`"%img_name%`")
	if(func_num=3)
		a=`npostmessage_img_click(`"%img_name%`")
	if(func_num=4)
		a=`nfind_img_trans_loop(`"%img_name%`")
	if(func_num=5)
		a=`nsleep`,%img_name%
	if(a!="")
		fileappend,%a%,%a_scriptdir%\functions.txt,UTF-8
	if(func_num=8)
	{
		a=`n`if(gsearch(`"%img_name%`")=true) `{%a_tab% `;%if_factor%`n
		fileappend,%a%,%a_scriptdir%\functions.txt,UTF-8
		a_num:=1
		gui,%y_cor%show
		gui,%y_cor%submit,nohide
		a:=chk_total_count(if_factor)
		loop,%a%
		{
			compile_one_line(a_num,y_cor)
			a_num++
		}
		gui,%y_cor%hide
		fileappend,`n`},%a_scriptdir%\functions.txt,UTF-8
	}
}


save_one_line(num,gui_no="1:")
{
	gui,%gui_no%submit,nohide
	
	GuiControl,%gui_no%Choose, My_list,%num%
	guicontrolget,line_output,%gui_no%,My_list
	Data_split(line_output,func_num,img_name,x_cor,y_cor,Loop_factor,if_factor)
	
	iniwrite,%line_output%,%a_scriptdir%\command_list.ini,%gui_no%
	if(func_num=2 or func_num=3 or func_num=4  or func_num=8 or func_num=9)
		iniwrite,%img_name%,%a_scriptdir%\img_list.txt,Used_img_list
	
	if(func_num=8)
	{
		a_num:=1
		gui,%y_cor%show
		gui,%y_cor%submit,nohide
		a:=chk_total_count(if_factor)
		loop,%a%
		{
			save_one_line(a_num,y_cor)
			a_num++
		}
		gui,%y_cor%hide
	}
}

save_all_line()
{
	fileselectfile,selectedFile,S24,,파일을 저장합니다.,7-zip (*.7z)
	if(selectedfile="")
		return 
	selectedfile:=chk_7z(selectedfile)
	
	gui,submit,nohide
	a:=chk_total_count("Ndure")
	num:=1
	y_cor:="1:"

	filedelete,%a_scriptdir%\command_list.ini
	filedelete,%a_scriptdir%\img_list.txt
	
	loop,%a%
	{
		save_one_line(num,y_cor)
		num++
	}
	
	IniRead,a,%a_scriptdir%\img_list.txt,Used_img_list
	sort,a,u
	inidelete,%a_scriptdir%\img_list.txt,Used_img_list
	iniwrite,%a%,%a_scriptdir%\img_list.txt,Used_img_list
	do_zipping(selectedFile)
	
	msgbox, all saved!
	GuiControl, , My_list_2, [ Command_list.ini, img_list.txt ] 저장 완료||
}



do_zipping(saving_name)
{
	setworkingdir,%a_scriptdir%
	num:=2
	ifnotexist,%a_scriptdir%\temp\imgs
		filecreatedir,%a_scriptdir%\temp\imgs
	
	filecreatedir,%a_scriptdir%\temp
	filecopy,%a_scriptdir%\command_list.ini,%a_scriptdir%\temp
	adrs=% a_scriptdir . "\imgs\"
	number_lines:=count_text_number(text)
	

	iniread,text,%a_scriptdir%\img_list.txt,Used_img_list
	sort,text,u
	loop,parse,text,`n,`r
	{
		N_adrs=% adrs . a_loopfield
		filecopy,%N_adrs% , %a_scriptdir%\temp\imgs,1
		ifnotexist,%N_adrs%
		{
			loop
				{
				sleep,20
				ifexist,%N_adrs%
					break
				}
		}
		GuiControl,1:, My_list_2, Saved Imgs : `[ %a_loopfield%`]||
	}
	
	

	sleep,50
	
	7z_compress(saving_name,a_scriptdir "\Temp")
	setworkingdir,%a_scriptdir%\imgs
	FileRemoveDir,%a_scriptdir%\temp,1
	
}

DeleteAlt(gui_name)  ; delete selected item
{
	gui,%gui_name%:submit,nohide
    sendmessage,0x188,,,listbox1 ;, % title            ;선택한 리스트 번호
    LB_GETCURSEL := errorlevel+1
    controlget, getITEM, choice,, listbox1 ;, % title         ;선택한 리스트이름
    guicontrol,,EDT,% LB_GETCURSEL . "`," . getITEM
	sendmessage,0x182,LB_GETCURSEL-1,,listbox1, % title            ;선택리스트 삭제
	guicontrol,%gui_name%:Choose,My_list,% LB_GETCURSEL-1
	GuiControl,%gui_no%Choose, My_list,%num%
return
}

count_text_number(text) {
	Loop, Parse, Text, `n, `r
		number_Lines := A_Index
	return number_Lines
	}


chk_7z(txt) {
StringRight,a,txt,3
if(a!=".7z")
	txt=% txt . ".7z"
return txt
}

unzipping_files() {
	SetWorkingDir,%a_scriptdir%
	FileSelectFile, SelectedFile, 3, , Open a file, 7z files (*.7z)
	if (SelectedFile = "")
		return false
	7z_extract(selectedfile)
	filecopydir,%a_scriptdir%\temp\imgs,%a_scriptdir%\imgs,1
	FileCopy,%a_scriptdir%\temp\command_list.ini,%a_scriptdir%\command_list.ini,1
	fileremovedir,%a_scriptdir%\temp
	SetWorkingDir,%a_scriptdir%\imgs
	return true
}


load_command_line()
{
	ifnotexist,%a_scriptdir%\command_list.ini
		return false
	num:=1
	fileread,a_txt,%a_scriptdir%\command_list.ini
	a:=count_text_number(a_txt)
	combined:=""
	loop,%a%
	{
		
		filereadline,a_line,%a_scriptdir%\command_list.ini,%num%
		RegExMatch(a_line, "\[(.*)\]", SubPat)
		if(subpat1!="")
			combined=% combined . "|" . subpat1
		num++
	}
	
	stringreplace,combined,combined,`|,
	stringsplit,combined,combined,`|
	num:=1
	loop,%combined0%
	{
		aa:=combined%num%
		iniread_from_this_section(aa)
		num++
	}
}



iniread_from_this_section(a_section) {
	iniread,section_txt,%a_scriptdir%\command_list.ini,%a_section%
	b:=reversing_txt(section_txt)
	stringsplit,output_reversed,b,`|
	num:=1
	loop,%output_reversed0%
	{
		a:=output_reversed%num%
		Data_split(a,func_num,img_name,x_cor,y_cor,Loop_factor,if_factor)
		if(func_num=8)
			{
				if_count++
				open_new_gui(y_cor,if_factor)
			}
		GuiControl,%a_section%,My_list, %a%||
		if(func_num=8)
			gui,%y_cor%hide
		num++
	}
	
}



reversing_txt(a_text) {
	combined:=""
	a:=count_text_number(a_text)
	
	FileAppend,%a_text%,%a_scriptdir%\temp.txt,UTF-8
	loop,%a%
	{
		filereadline,out_put,%a_scriptdir%\temp.txt,%a%
		combined=% combined . "|" . out_put
		a--
	}
	
	stringreplace,combined,combined,`|,
	FileDelete,%a_scriptdir%\temp.txt
	return combined
}


saved_data_all_load()
{
	MsgBox, 4, 진행 여부, 로드시 현재의 모든 데이터가 삭제됩니다. 괜찮습니까?
		ifmsgbox,no
			return
	Main_My_list_all_clear()
	a:=unzipping_files()
	SetWorkingDir,%a_scriptdir%\imgs
	if(a=true)
	{
		if_count=0
		b:=load_command_line()
			if(b=false)
				msgbox, 오류(command_list.ini를 찾을 수 없습니다.)
	}
	else
		msgbox, 취소하셨습니다
	if(a=true)
		msgbox, All_Action_command_completely Loaded !!
	
}

Main_My_list_all_clear()
{
	sendmessage,0x184,,,Listbox1,Ndure         ;전체 삭제
    ;~ sendmessage,0x18B,,,Listbox1, Ndure        ;총 리스트수 구하기
    ;~ getCOUNT := errorlevel
	;~ msgbox,% getcount
    ;~ guicontrol,,EDT,% "Total : " . errorlevel
}




translate_action(list_selected)
{
	Data_split(list_selected,func_num,img_name,x_cor,y_cor,Loop_factor,if_factor) ; vStatus_translate
	if(func_num=1)
		translated=% "마우스 클릭 " . "[ " . x_cor . "`," y_cor . " ]"
	if(func_num=2)
		translated=% "이미지 기다림 클릭 " . "[ " . img_name . " ]" 
	if(func_num=3)
		translated=% "이미지 있을 시 클릭 " . "[ " . img_name . " ]"
	if(func_num=4)
		translated=% "이미지 정밀 서치 클릭 " . "[ " . img_name . " ]"
	if(func_num=5)
		translated=% "지정한 시간 만큼 슬립 " . "[ " . img_name . " ms ]"
	;~ if(func_num=6)
		
	;~ if(func_num=7)
		
	if(func_num=8)
		translated=% "이미지 서치 후 [참]일 때" . "`n[ " img_name . " ]`n" . "창 경로 [" . x_cor . " " . "->" . " " . y_cor . " ]" . "`n" . "여는 창이름 " . "[ " . if_factor . " ]"
	;~ if(func_num=9)
		
	;~ if(func_num=10)
	
	return translated
}


disabling_btns()
{
btns=
(

save_btn
del_btn
doit_btn

)
;~ imgcapture_btn
loop,parse,btns,`n,`r
	guicontrol,1:Disable,%a_loopfield%

}

enabling_btns() {
btns=
(
action_to_exe_btn
save_btn
del_btn
doit_btn

)
;~ imgcapture_btn
loop,parse,btns,`n,`r
	guicontrol,1:enable,%a_loopfield%

}

chk_update() {
GuiControl, , My_list_2, Checking : 업데이트 확인중||
source:=ReadURL("https://drive.google.com/open?id=10ltWE3n7qquQ_kqjkUjaqUyfq8REKRiXemHdG6IXxok")
GuiControl, , My_list_2, Checking : 업데이트 확인끝||
if(source="")
	return
RegExMatch(source,"meta property=""og:description"" content=\C(.*)\C><meta name=""google""",msg_a)
stringsplit,splited,msg_a,`|,`r
if(splited2="사용불가")
	{
		MsgBox, 0, 사용중지 안내, 개발자가 사용을 막았습니다., 20
		gui,1:destroy
		ExitApp
	}

if(splited4!=current_version) {
	if(splited3!="URL")
{
	MsgBox, 4, 진행 여부, 업데이트가 있습니다. 업데이트 파일을 확인하시겠습니까?
	ifmsgbox,yes
	{
		Clipboard=%splited3%
		GuiControl, , My_list_2, Checking : 업데이트 파일의 다운용 주소가 복사됨||
		msgbox,업데이트 파일의 주소가 복사되었습니다.
	}
	else
		return
}}}


	

compile_gui_include_etc()
{
a=
(
ifnotexist,`%A_scriptdir`%\imgs
	FileCreateDir,`%a_scriptdir`%\imgs
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.`n`r
; #Warn  ; Enable warnings to assist with detecting common errors.`n`r
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.`n`r
SetWorkingDir `%A_ScriptDir`%\imgs  ; Ensures a consistent starting directory.`n`r

#include G_search.G_click.ahk`n`r
#include URL.ahk`n`r
`n`r
global g_title,hwnd,g_class,g_class_exe,g_control`n`r
global start`n`r

Gui, new_compiled:Add, ListBox, w280 h200 vMy_list_2, `n`r
Gui, new_compiled:Add, Button, w280 h40 gdoit_actions Disabled vdoit_btn, Do it!`n`r
Gui, new_compiled:Add, Button, w280 h40 gpause_btn, `Pause/unpause`n`r
Gui, new_compiled:Add, Button, w280 h40 greload_btn, `Reload`n`r
gui, new_compiled:show,,Ndures Macro`n`r
chk_update()`n`r
process_load()`n`r
return`n`r
`n`r
reload_btn:`n`r
Reload`n`r
return`n`r
`n`r
pause_btn:`n`r
msgbox,일시정지/일시정지 해제`n`r
Pause`n`r
return`n`r
`n`r
doit_actions:`n`r
start := A_TickCount`n`r
loop`n`r
doit_compiled_action()`n`r
return`n`r
`n`r
new_compiledguiclose:`n`r
ExitApp`n`r

chk_update() {`n`r
GuiControl,new_compiled: , My_list_2, Checking : 확인중||`n`r
source:=ReadURL("https://drive.google.com/open?id=10ltWE3n7qquQ_kqjkUjaqUyfq8REKRiXemHdG6IXxok")`n`r
GuiControl,new_compiled: , My_list_2, Checking : 확인끝||`n`r
if(source="")`n`r
	return`n`r
RegExMatch(source,"meta property=""og:description"" content=\C(.*)\C><meta name=""google""",msg_a)`n`r
stringsplit,splited,msg_a,```|,``r`n`r
if(splited2="사용불가")`n`r
	{`n`r
		MsgBox, 0, 사용중지 안내, 개발자가 사용을 막았습니다., 20`n`r
		gui,new_compiled:destroy`n`r
		ExitApp`n`r
	}`n`r
else`n`r
	guicontrol,new_compiled:enable,doit_btn`n`r
}`n`r
`n`r
process_load() {`n`r
iniread,g_title,`%a_scriptdir`%\process_info.ini,process_info,g_title`n`r
iniread,hwnd,`%a_scriptdir`%\process_info.ini,process_info,hwnd`n`r
iniread,g_class,`%a_scriptdir`%\process_info.ini,process_info,g_class`n`r
iniread,g_class_exe,`%a_scriptdir`%\process_info.ini,process_info,g_class_exe`n`r
iniread,g_control,`%a_scriptdir`%\process_info.ini,process_info,g_control`n`r
GuiControl,new_compiled: , My_list_2,타이틀 : `[`%g_title`%]||`n`r
GuiControl,new_compiled: , My_list_2,hwnd : `[`%hwnd`%]||`n`r
GuiControl,new_compiled: , My_list_2,class : `[`%g_class`%]||`n`r
GuiControl,new_compiled: , My_list_2,exe : `[`%g_class_exe`%]||`n`r
GuiControl,new_compiled: , My_list_2,ClassNN : `[`%g_control`%]||`n`r

`n`r
}`n`r
`n`r


doit_compiled_action() {`n`r
if(a_tickcount-start>=20000)`n`r
{`n`r
start:=a_tickcount`n`r
guicontrol,new_compiled:,My_list_2,|`n`r
}`n`r
`n`r
)
	fileappend,%a%,%a_scriptdir%\functions.txt,UTF-8
return
}


