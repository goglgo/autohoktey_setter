
/*
To do list

Save버튼 및 다른 func들 
if 및 loop의 알고리즘 재고
완)Delete 버튼도 할 것
각)Listbox를 통째로 저장하는 방법 재고
완)Doit_btn 알고리즘 재고
border계산 하여 클릭할 것

IF,Loop문은 리스트박스를 새로 열고 파괴하고 새로열고 파괴하고 txt를 새로 만들고, 탈출시엔 -1로 이케
IF,Loop문은 No를 추가해서 삭제와 추가시 확인할 것
새로운 IF분Loop문 추가는 _로 할 것
로드시 IF 순차적으로 파일및 구문 확인할 것


끼워넣기
.zip 저장
이미지 백업/로드
리스트 박스를 움직일 때마다 ADD_Status로 해독



*/
;;;;;;;;;;



coordmode,mouse,client

global action_naming,action_naming_2,combined_naming,current_If_w_name,if_count
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
#include G_search.G_click.ahk
#include completed_functions.ahk
Gui, Add, ListBox, x12 y29 w280 h200 vMy_list gLBevent, 
Gui, Add, ListBox, x12 y229 w280 h200 vMy_list_2, 
Gui, Add, Button, x562 y49 w110 h20 gadd_actions, ADD
Gui, Add, Button, w110 h20 gdel_action, Delete
Gui, Add, Button, w110 h20 gsave_actions, Save
Gui, Add, Button, w110 h20 gLoad_saved_dat_g , LOAD
Gui, Add, Button, w110 h30 gdoit_actions , Do it!
Gui, Add, DropDownList, x302 y49 w200 h200 vAction_1 gdropdown_1 ,%action_naming%
;Gui, Add, DropDownList, x302 y49 w200 h200 vAction_1 gdropdown_1 ,좌표 클릭|이미지 기다림 클릭|이미지 있을 시 클릭|이미지 정밀서치클릭|Sleeping
Gui, Add, DropDownList, w200 h200 gdropdown_2 vAction_2,%action_naming_2%
Gui, Add, Text,w200 h40 vadd_status vStatus_translate, ADD_status
Gui, Add, Button, x572 y-1 w100 h30 gopen_process_select_gui , 프로세스 선택
Gui, Add, Text, x302 y9 w260 h40 vMain_process_text , Process_select

; Generated using SmartGUI Creator for SciTE

; Generated using SmartGUI Creator for SciTE
Gui, Show, w687 h480,Ndure

;a:=DllCall("GetCurrentProcessId")
;a:=dllcall("getcurrentprocesstitle")
;WinGet, ControlList, ControlList, A ;;컨트롤 리스트 전부 얻어오기
;WinGetText,g_text,%g_title% ;;텍스트 얻어오기

;;현재 창의 hwnd, title, class, class_exe, classNN 값 가져오기
global g_Title,hwnd,g_class,g_class_exe,g_control,check_process_gui,check_coord_add,vx,vy,data_one
global func_num,img_name,x_cor,y_cor,Loop_factor,if_factor,a_time
global WindowCaptionHeight,WindowBorderWidth,WindowBorderHeight

check_process_gui:=0
check_coord_add:=0
clk_delay:=100
data_one := Object()

checking_saved_dat()

return

LBevent_If:
	msgbox
return

LBevent:
;~ gui,submit,nohide
    ;~ ifEqual, a_guievent, doubleclick, msgbox,64,info, % a_eventinfo,1  ;리스트를 더블클릭했을때 리스트번호 얻기
	
	if(a_guievent="doubleclick")
	{
	doit_line(%a_eventinfo%) ;;;temp
}
    return

doit_actions:
settimer,,off
if(chk_select_proc()=false)
{
	msgbox,프로세스를 설정해주세요.
	return
}

count_total_actions(action_count)
	;~ gui_no=""
	num:=1
	;msgbox,%action_count%
	a_count_Mylist2:=0
loop
	{
	loop,%action_count%
	{
	doit_line(num,gui_no)
	num++
	a_count_Mylist2++
	;GuiControl, , Status_translate,%a_count_Mylist2% ;;;;현재 리스트박스를 해석해서 보여줌
	if(a_count_Mylist2>200)
		{
		;msgbox,123
		a_count_Mylist2:=0
		GuiControl, , My_list_2,|
		GuiControl, , My_list_2, `[로그 초기화`]||
		}
	}
num:=1
}


return
Load_saved_dat_g:
Load_saved_dat()
return

dropdown_2:
gui,submit,nohide
;msgbox,12
;GuiControl, , Action_2, sd|
adding_actions(Action_2)
;msgbox,%func_num%
return

F2::
ExitApp

dropdown_1:
;;fileread
;;펑션번호,이미지,x좌표,y좌표,루프여부,if_factor
;;펑션 리스트
;;1번 좌표클릭
;;2번 이미지 기다림 클릭
;;3번 이미지 있을 시 클릭
;;4번 이미지 정밀 서치
;;;좌표 클릭|이미지 기다림 클릭|이미지 있을 시 클릭|이미지 정밀서치클릭|Loop(루프 시작)|Loop end(루프 끝)|If(조건문)|End if(조건문 끝)
gui,submit,nohide
adding_actions(Action_1)
return

save_actions:
save_actions_g()
GuiControl, , My_list_2, `[Actions Saved`]||
return

2guiclose:
check_process_gui=0
settimer,,off
gui,2:Destroy
return

guiclose:
exitApp

add_actions:
;add_action()
msgbox,작업중
return

del_action:
DeleteAlt()
return



open_process_select_gui:
ifwinnotexist,Select_process
{	
	settimer,get_realtime_program_info,100
	wingetpos,nx,ny,nw,nh,Ndure
	nx:=nx-210
	Gui,2:Add, Text, x12 y9 w170 h150 vProcess_info_text , F8
	Gui, 2:Show,x%nx% y%ny% w205 h180,Select_process
	return
}
ifwinexist,Select_process
{
	settimer,,off
	gui,2:Destroy
}
return


If_adding_action_check_last_num(data_one)
{
num=1
StringSplit, data_one, get_IF_window, "....."
;msgbox,% data_one . data_one1

Loop{
	if(data_one%num%="")
		return num
	num++
}

return
}

IF_adding_action:
WinGetActiveTitle,get_IF_window
a:=If_adding_action_check_last_num(get_IF_window)
;~ msgbox,% a
a= % "IF" . a . ":"
;msgbox,%a%
gui,%a%submit,nohide
adding_actions(Action_If,a)
return

;vAction_If

f3:: ;;;;testing_area

if_factor:=1
img_name=filename
current_If_w_name=123
;errrrrrrrrrrrrrrrrrrrr
;;adding_if_true()
;inputbox,img_name,조건 이름,IF조건의 이름을 정해주세요.
;~ if ErrorLevel
;~ {
	;~ msgbox,취소를 누르셨습니다
	;~ return
;~ }
;----------------------------------------------------------------------------여기서
;;
;
;;;;;변수로써 무수히 많은 gui창을 만듬
current_If_w_name=% if_factor . "....." . img_name
;IFlist=% "IFlist_" . if_factor

;;exam> IF1
;;vAction 새로운 gui의 라벨이라 중복가능, 중복 함수호출도 가능
Gui, IF%if_factor%:Add, ListBox, w280 h200 vMy_list gLBevent_If,sd|sdf|sdf
Gui, IF%if_factor%:Add, DropDownList, w200 h200 gIF_adding_action vAction_If,%combined_naming%
;Gui, IF%if_factor%:Add, button, w280 h30 ,좌표클릭
gui, IF%if_factor%:show,,% current_If_w_name
;gui,IF1:submit,nohide
;~ GuiControlGet,

GuiControl,If1:Choose, My_list,2
guicontrolget,asd,If1:,My_list
msgbox, % asd
;~ gui,%a%submit,nohide
;gui,getmouse:Destroy

return





get_realtime_program_info:
{
	IfWinnotExist,Select_process
		settimer,get_realtime_program_info,off
	get_active_program_info()
	GuiControl, 2: , Process_info_text , Title : %g_Title% `n`nHWND : %hwnd%`n`nClass : %g_class%`n`nClass_exe : %g_class_exe%`n`nClassNN : %g_control%
	return
}


getmouseguiclose:
#ifwinexist
gui,getmouse:Destroy
return


;;;단축키

#ifwinexist,Mouse position
{
f8::
mouse_coord_add()

#ifwinexist
return
}
		
#IfWinExist,Select_process
{
	f8::
	{
		get_active_program_info()
		GuiControl, 2: , Process_info_text , Title : %g_Title% `n`nHWND : %hwnd%`n`nClass : %g_class%`n`nClass_exe : %g_class_exe%`n`nClassNN : %g_control%
		MsgBox, 4, 진행 여부, `[%g_title%`]이것으로 진행합니까?
			ifmsgbox,yes
			{
				Gui, 2:destroy
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


chk_select_proc() ;; if(chk_select_proc()=false)
{
	if(g_title="")
		return false
	else
		return true
}


adding_actions(input_action,gui_no="") {
;좌표 클릭|이미지 기다림 클릭|이미지 있을 시 클릭|이미지 정밀서치클릭|Sleeping|Loop(루프 시작)|Loop end(루프 끝)
;IF(이미지 서치)[참]|IF(이미지 서치)[거짓]|IF(픽셀서치)[참]|IF(픽셀서치)[거짓]|
;       8                 9                    10              11

	gui,%gui_no%submit,nohide

init_function()
get_func_num(input_action) ;Action_1
	if(func_num=1)												;;;좌표클릭설정
	{
		msgbox,F8로 좌표를 설정합니다.(마우스 선택창에 F8한줄 추가)
		winactivate,%g_title%
		getting_mouse_pos()
	}
	if(func_num=2 or func_num=3 or func_num=4) 					;;;이미지 클릭 시리즈
	{
		img_load_copy()
	}
	if(func_num=5) 												;;;슬립
	{
		sleep_time:=input_sleep_time()
		if(sleep_time=false)
			return
		img_name:=sleep_time
	}
	;;;6이랑 7은 루프설정
	if(func_num=8)  ;;IF서치 참
	{
		if(chk_go_on_yesorno("ㅇㅇ")=true)
			if_count++
		;;;;;취소여부확인에 따라 if factor에 따라 새로운 창을 만듬
		
	}
	if(func_num=9)
	{
		msgbox,456
		;;IF용 함수 실행
	}
add_action(gui_no)
return
}



get_func_num(input_action_name) ;; func_num:=get_func_num(action_naming,Action_1)
{
	num_a:=1
	num_b:=1
	StringSplit, data_one, combined_naming, `|
	Loop
	{
		;msgbox,% input_action . data_one%num_a%
		if(data_one%num_a%="" && data_one%num_a%=input_action_name)
		{
			msgbox,% data_one%num_a% . func_num
			break

		}
		if(input_action_name=data_one%num_a%)
			{
				;~ msgbox,%num_a%
				func_num=%num_a%
				break
			}

				num_a++

	}
	;~ StringSplit, data_two, action_naming_2, `|
	;~ Loop
	;~ {
		;~ if(data_two%num_b%="")
		;~ {
			;~ msgbox,불일치 에러 발생
			;~ return
		;~ }
		;~ if(input_action_name=data_two%num_b%)
			;~ {
			;~ func_num=%num_a%
			;~ break
			;~ }
		;~ num_a++
		;~ num_b++
	;~ }
	
	return func_num
}


checking_saved_dat()
{

ifexist,%a_scriptdir%\save_dat.txt
	{
	fileread,Text,%a_scriptdir%\save_dat.txt
	Loop, Parse, Text, `n, `r
		number_Lines := A_Index
;		msgbox,%num_lines%
	if (number_Lines="") {
		GuiControl, , My_list_2, Load Fail : `[빈 파일 입니다.`]
		return
	}
	MsgBox, 4, 진행 여부, 저장되있는 파일을 찾았습니다. 로드합니까?
		ifmsgbox,yes
		{
			src=%a_scriptdir%\save_dat.txt
			;msgbox,%src%
			Load_file_read(src)
			;GuiControl, , My_list_2, Load Saved Data.
			return
		}
		ifmsgbox,no
			{
				msgbox,그냥 진행하겠습니다
				return
			}
}
else
	return
return
}

chk_go_on_yesorno(go_on_msg="진행합니까?")
{
MsgBox, 4, 진행 여부, %go_on_msg% ;저장되있는 파일을 찾았습니다. 로드합니까?
ifmsgbox, yes
	return true

ifmsgbox,no
	return false
}


Load_saved_dat()
{
;;펑션번호,이미지,x좌표,y좌표,루프여부,if_factor
;;func_num,img_name,x_cor,y_cor,Loop_factor,if_factor
FileSelectFile, to_load_file, 3, , Open a file, txt (*.txt; *.dat)
	if (to_load_file = "")
		return
	Load_file_read(to_load_file)
	return
}

Load_file_read(to_load_file)
{
	number_lines:=0
;msgbox,%to_load_file%

fileread,Text,%to_load_file%
;msgbox,%text%
Loop, Parse, Text, `n, `r
    number_Lines := A_Index
;number_lines:=number_lines
if (number_lines=0) {
	GuiControl, , My_list_2, Load Fail : `[파일을 찾았으나 빈 파일 입니다.`]
	;msgbox, 빈 파일입니다.
	return
}
num:=1
loop,%number_lines%
{
	filereadline,readed_text,%to_load_file%,%num%
	GuiControl, , My_list,%readed_text%||
	num++
}
GuiControl, , My_list_2, `[로드 완료`]
return
}

Data_split(line_output)
{
	StringSplit, data_one, line_output, `,
	func_num:=data_one1
	img_name:=data_one2
	x_cor:=data_one3
	y_cor:=data_one4
	Loop_factor:=data_one5
	if_factor:=data_one6
	
	if(func_num=5)
		a_time:=img_name
	
	return
}

f4::
doit_line(1,"If1:")
return


doit_line(num,gui_no="") ;;;temp
{
	
	;;좌표 클릭|이미지 기다림 클릭|이미지 있을 시 클릭|이미지 정밀서치클릭|Sleeping|Loop(루프 시작)|Loop end(루프 끝)|If(조건문)|End if(조건문 끝)
;	init_function()

	gui,%gui_no%submit,nohide
	GuiControl,%gui_no%Choose, My_list,%num%
	guicontrolget,line_output,%gui_no%,My_list

	Data_split(line_output)
	
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

	if(func_num=4) ; 이미지 정밀서치 클릭
		find_img_trans_loop(img_name)
	if(func_num=5) ;sleep
	{
		sleep_a_time(a_time)
	}
	if(func_num=6) ; 루프시작
		msgbox,준비중
	if(func_num=7) ; 루프 끝
		msgbox,준비중
	if(func_num=8) ;If 이미지서치 참
	{
		msgbox,2
	}
	if(func_num=9) ;If 이미지서치 거짓
		msgbox,준비중

	return
}

sleep_a_time(sleep_time)
{
	GuiControl, , My_list_2, Sleeping : `[%sleep_time%`]||
	sleep,%sleep_time%
	GuiControl, , My_list_2, End `Sleep||
}


add_action(gui_no)
{
	a=%func_num%,%img_name%,%x_cor%,%y_cor%,%Loop_factor%,%if_factor%
	b=%func_num%,,,,,
	if(a!=b && gui_no="")
		GuiControl, , My_list,%a%||
	if(a!=b && gui_no!="")
		GuiControl,%gui_no%, IFlist,%a%||
	
	return
}

doit_list_choice(num,gui_no="")
{
	;~ GuiControl,If1:Choose, IFlist,1
	if(gui_no="")
	GuiControl, Choose, ListBox1, %num%
	else
		GuiControl,%gui_no%:Choose, IFlist,%num%
	sleep,10
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

inactive_pixel_get(x,y,byref ARGB)
{
;~ msgbox,%x%,%y%,%hwnd%
pToken:=Gdip_Startup()
pBitmap:=Gdip_BitmapFromhwnd(hwnd)
clipboard=%pBitmap%
ARGB := Gdip_GetPixel(pBitmap, x, y)

setformat,integer,hex
ARGB +=0
GuiControl, , My_list_2, `[%x%,%y% : `Color %ARGB%`]
;msgbox %ARGB%

GDIP_DisposeImage(pBitmap)
GDIP_Shutdown(pToken)
return
}

getting_mouse_pos() {
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
				return
			}
		}
	}}

;~ eat_potion()
;~ {
;~ inactive_pixel_get(65,66,ARGB)
;~ if(ARGB!="0xffdd280a")
	;~ postmessage_click(633,267)
;~ inactive_pixel_get(59,79,ARGB)
;~ if(ARGB!="0xff189cff")
	;~ postmessage_click(685,272)
;~ }