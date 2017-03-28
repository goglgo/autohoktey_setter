/* coord.txt
362,343 ;진입 후 첫 댓글 좌표
393,348 ;좌표 못찾았을 때 내린 후의 첫 댓글 좌표
34,711  ;사진고르고 
40,175 ---눌렀다 떼는
32,93 ;;붙여넣기 클릭
61,54 ; 마이블로그 뒤로버튼
26,26 ;; 마이블로그 광고 끄기 버튼
*/
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include G_search.G_click.ahk

coordmode,mouse,client

Gui, Add, ListBox, x12 y9 w200 h290 vMyListBox , 시작합니다|
Gui, Add, Button, x325 y35 w80 h30 glog_clear,로그 클리어
Gui, Add, Button, w80 h30 ginit_coord ,좌표 초기화
Gui, Add, Edit, x232 y9 w60 h20 vto_count , 1
Gui, Add, Button, w80 h30 gcheck_run,구동확인
Gui, Add, Button, w80 h30 goptimize_coord,좌표`n 수동설정

;Gui, Add, Edit, x162 y39 w60 h30 , 2
;Gui, Add, Edit, x252 y39 w60 h30 , 3
;Gui, Add, button, x312 y230 w100 h30 gstart_macro , 실행
Gui, Add, Text, x228 y109 w300 h150 vstatus_bar, 실행 : ....
Gui, Add, Text, x320 y9 w60 h20 , 댓글 횟수
;Gui, Add, Text, x222 y39 w30 h40 , X
;Gui, Add, Text, x312 y39 w40 h30 , Y
Gui, Add, Text, x250 y200 w200 h30 vdelay_dp, [F9]delay : 1000ms`(1sec`)
gui,add,text,w200 h30 vcycle_num,총 0회 사이클 진행
;gui,add,button,run

; Generated using SmartGUI Creator for SciTE
Gui, Show, w425 h313, Work_automation_Ndure


global hwnd, g_class , count_list, status_A, status_B,status_tot,clk_delay,g_title ,vx, vy
global g_text,g_control,count_down,curr_count,g_title_m,g_text_m,to_count,optimize_coord_onoff

;;process_setting
g_class=ahk_class Afx:400000:b:10003:0:0
g_class_exe=ahk_exe Mobizen.exe
g_title=ViewerWnd
g_control=AfxWnd42u35
g_text=

g_text_m=	Mobizen Mirroring
g_title_m=Mobizen Mirroring

winget,hwnd,,%g_title%

status_B:="작동중이지 않음"


f5::  ;;texsting_func.


;GuiControl, , MyListBox, 좌표설정:(%vx%,%vy%)||
;postmessage_click(362,343) ;진입 후 첫 댓글 좌표
;postclick_setted_coord(2)

;text_cb:=
;~ text_cb= %text_cb%`n`r . "sdf"
;~ fileappend,%text_cb%,sdf.txt




;msgbox,%vx%

;;;;gsearch 예제
;~ if(gsearchxy("option.png",vx,vy)=true)
;~ {
	;~ msgbox,%vx% %vy%
	;~ postmessage_click(vx,vy) ;;example
;~ }
;~ else

;postmessage_click(362,343)

;postclick_setted_coord(2)

return



postmessage_click(vx,vy)
{

vx:=vx+1
vy:=vy+1
  
  
lparam:=vx|vy<<16
;msgbox,%lparam%
GuiControl, , MyListBox, Clicked:(%vx%,%vy%)||
postmessage,0x201,1,%lparam%,%g_control%, %g_title%
sleep,50
postmessage,0x202,0,%lparam%,%g_control%, %g_title%
sleep,%clk_delay%

return
}

postmessage_click_holding(vx,vy,hold_time)
{
	;클리크 수정
  ;vx:=vx+5
  ;vy:=vy+5
  
  lparam:=vx|vy<<16
  ;msgbox,%lparam%
  GuiControl, , MyListBox, holding:(%vx%,%vy%)||
  postmessage,0x201,1,%lparam%,%g_control%, %g_title%
  sleep,%hold_time%
  postmessage,0x202,0,%lparam%,%g_control%, %g_title%
  GuiControl, , MyListBox, unholding:(%vx%,%vy%)||  
return
}

post_Esc()
{
GuiControl, , MyListBox, ESC 키 입력||
PostMessage, 0x100, 27, 65537, %g_control%, %g_title%
sleep,70
PostMessage, 0x101, 27, 65537,%g_control% , %g_title%
}


post_Enter()
{
GuiControl, , MyListBox, ENTER 키 입력||
PostMessage, 0x100, 0xD, 0x1C0001,%g_control% , %g_title%
sleep,70
PostMessage, 0x101, 0xD, 0xC01C0001,%g_control% , %g_title%
}

find_img_trans_loop(image)
{
	trnas_num:=0
	a_text:=""
	loop,100
	{
		if(find_img_trans(image,trans_num,vx,vy)=true)
		{
			a_text=%a_text%`r`n Trans`[%trans_num%`]인 `[%image%`]를 `[%vx%,%vy%`] 좌표에서 발견
		}
		trnas_num++
	}
	%Clipboard%:=%a_text%
}

find_img_trans(image,trans_num,byref vx,byref vy)
{
  pToken:=Gdip_Startup()
 pBitmapHayStack:=Gdip_BitmapFromhwnd(hwnd)
 pBitmapNeedle:=Gdip_CreateBitmapFromFile(image)
  if Gdip_ImageSearch(pBitmapHayStack,pBitmapNeedle,list,0,0,0,0,trans_num,,1,1)
  {
  StringSplit, LISTArray, LIST, `,
  
;vx=vx+5
 ; vy=vy+5
  vx:=LISTArray1 
  vy:=LISTArray2
  
   lparam:=vx|vy<<16

;postmessage,0x201,1,%lparam%,%g_control%, %g_title%
;sleep,70
;postmessage,0x202,0,%lparam%,%g_control%, %g_title%
  
  
  Gdip_DisposeImage(pBitmapHayStack), Gdip_DisposeImage(pBitmapNeedle)
  Gdip_Shutdown(pToken)
  
  return true
  }
  else
  {
  
  Gdip_Shutdown(pToken)
; guicontrol , , Status_text, fail %image%
  return false
  }
}

postmessage_img_click(img)
{
if(gsearchxy(img,vvx,vvy)=true)
{
postmessage_click(vvx,vvy)
;msgbox,%vvx%,%vvy%
}
else
	GuiControl, , MyListBox, `[ %img% `] Failed
}
return

postclick_setted_coord(num)
{
COORD_Array := Object()
filereadline,line_output,coord.txt,num
StringSplit, COORD_Array, line_output, `,

vx:=COORD_Array1 
vy:=COORD_Array2
postmessage_click(vx,vy) ;;example
}

postclick_setted_coord_hold(num)
{
COORD_Array := Object()
filereadline,line_output,coord.txt,num
StringSplit, COORD_Array, line_output, `,

vx:=COORD_Array1 
vy:=COORD_Array2
postmessage_click_holding(vx,vy,800)
}



