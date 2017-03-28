#singleinstance force
#notrayicon
 
title = ListBox 예제


gui,add,listbox,xm ym w100 r20 vLB choose1 gLBevent,목소리|음성|공감|솔직|편지|지폐|선물
gui,add,edit  ,xm    yp+250 w200 vEDT -background
gui,add,button,xm+110 ym    w130 h20 gBTN1,총 리스트수
gui,add,button,xp     yp+20 wp hp gBTN2,추가
gui,add,button,xp     yp+20 wp hp gBTN3,선택한 다음줄에 삽입
gui,add,button,xp     yp+20 wp hp gBTN4,랜덤 선택
gui,add,button,xp     yp+20 wp hp gBTN5,선택줄 삭제
gui,add,button,xp     yp+20 wp hp gBTN6,전체 삭제
gui,add,button,xp     yp+20 wp hp gBTN7,선택줄 번호/이름
gui,add,button,xp     yp+20 wp hp gBTN8,Height 간격조절
gui,add,button,xp     yp+20 wp hp gBTN20,재실행
gui,add,button,xp     yp+20 w65 hp glistboxUPDOWN vitemUP,위로
gui,add,button,xp+65  yp    wp hp glistboxUPDOWN vitemDN,아래로
gui,show,,% title
return
LBevent:
    ifEqual, a_guievent, doubleclick, msgbox,64,info, % a_eventinfo,1  ;리스트를 더블클릭했을때 리스트번호 얻기
    return
BTN1:
    sendmessage,0x18B,,,listbox1, % title        ;총 리스트수 구하기
    getCOUNT := errorlevel
    guicontrol,,EDT,% "Total : " . errorlevel
    return
BTN2:
    sendmessage,0x180, , "리스트추가" . a_msec, listbox1, % title            ;추가
    gosub BTN1
    return
BTN3:
    gosub BTN7
    sendmessage,0x181, LB_GETCURSEL, "리스트삽입" . a_msec, listbox1, % title            ;선택한 줄 다음에 라인 삽입
    gosub BTN1
    return   
BTN4:
    gosub BTN1
    random,NUM,0,% getCOUNT-1
    sendmessage,0x186,NUM,,listbox1, % title            ;번호로 리스트 선택
    return   
BTN5:
    gosub BTN7
    sendmessage,0x182,LB_GETCURSEL-1,,listbox1, % title            ;선택리스트 삭제
    return   
BTN6:
    sendmessage,0x184,,,listbox1, % title            ;전체 삭제
    gosub BTN1
    return   
BTN7:
    sendmessage,0x188,,,listbox1, % title            ;선택한 리스트 번호
    LB_GETCURSEL := errorlevel+1
    controlget, getITEM, choice,, listbox1, % title         ;선택한 리스트이름
    guicontrol,,EDT,% LB_GETCURSEL . "`," . getITEM
    return   
BTN8:
    sendmessage,0x1A0,,15, listbox1, % title        ;Height 간격 조절
    guicontrol,+redraw,LB
    return   
listboxUPDOWN:            ;항목 이동하기
    gui,submit,nohide
    sendmessage,0x18B,,,listbox1, % title        ;총 줄수
    LB_GETCOUNT := errorlevel
    sendmessage,0x188,,,listbox1, % title            ;선택리스트 번호 얻기
    ifequal,a_guicontrol,itemUP,ifequal,errorlevel,0,return
    ifequal,a_guicontrol,itemDN,ifequal,errorlevel,% LB_GETCOUNT-1,return
    LB_GETCURSEL := errorlevel
    sendmessage,0x182,LB_GETCURSEL,,listbox1, % title            ; 리스트 삭제
    sendmessage,0x181,LB_GETCURSEL + (a_guicontrol="itemDN" ? 1:-1),"" . LB, listbox1, % title    ;추가
    sendmessage,0x186,LB_GETCURSEL + (a_guicontrol="itemDN" ? 1:-1),,listbox1, % title    ;선택
    return
BTN20:
    reload
guiescape:
guiclose:
 exitapp