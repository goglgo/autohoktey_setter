#singleinstance force
#notrayicon
 
title = ListBox ����


gui,add,listbox,xm ym w100 r20 vLB choose1 gLBevent,��Ҹ�|����|����|����|����|����|����
gui,add,edit  ,xm    yp+250 w200 vEDT -background
gui,add,button,xm+110 ym    w130 h20 gBTN1,�� ����Ʈ��
gui,add,button,xp     yp+20 wp hp gBTN2,�߰�
gui,add,button,xp     yp+20 wp hp gBTN3,������ �����ٿ� ����
gui,add,button,xp     yp+20 wp hp gBTN4,���� ����
gui,add,button,xp     yp+20 wp hp gBTN5,������ ����
gui,add,button,xp     yp+20 wp hp gBTN6,��ü ����
gui,add,button,xp     yp+20 wp hp gBTN7,������ ��ȣ/�̸�
gui,add,button,xp     yp+20 wp hp gBTN8,Height ��������
gui,add,button,xp     yp+20 wp hp gBTN20,�����
gui,add,button,xp     yp+20 w65 hp glistboxUPDOWN vitemUP,����
gui,add,button,xp+65  yp    wp hp glistboxUPDOWN vitemDN,�Ʒ���
gui,show,,% title
return
LBevent:
    ifEqual, a_guievent, doubleclick, msgbox,64,info, % a_eventinfo,1  ;����Ʈ�� ����Ŭ�������� ����Ʈ��ȣ ���
    return
BTN1:
    sendmessage,0x18B,,,listbox1, % title        ;�� ����Ʈ�� ���ϱ�
    getCOUNT := errorlevel
    guicontrol,,EDT,% "Total : " . errorlevel
    return
BTN2:
    sendmessage,0x180, , "����Ʈ�߰�" . a_msec, listbox1, % title            ;�߰�
    gosub BTN1
    return
BTN3:
    gosub BTN7
    sendmessage,0x181, LB_GETCURSEL, "����Ʈ����" . a_msec, listbox1, % title            ;������ �� ������ ���� ����
    gosub BTN1
    return   
BTN4:
    gosub BTN1
    random,NUM,0,% getCOUNT-1
    sendmessage,0x186,NUM,,listbox1, % title            ;��ȣ�� ����Ʈ ����
    return   
BTN5:
    gosub BTN7
    sendmessage,0x182,LB_GETCURSEL-1,,listbox1, % title            ;���ø���Ʈ ����
    return   
BTN6:
    sendmessage,0x184,,,listbox1, % title            ;��ü ����
    gosub BTN1
    return   
BTN7:
    sendmessage,0x188,,,listbox1, % title            ;������ ����Ʈ ��ȣ
    LB_GETCURSEL := errorlevel+1
    controlget, getITEM, choice,, listbox1, % title         ;������ ����Ʈ�̸�
    guicontrol,,EDT,% LB_GETCURSEL . "`," . getITEM
    return   
BTN8:
    sendmessage,0x1A0,,15, listbox1, % title        ;Height ���� ����
    guicontrol,+redraw,LB
    return   
listboxUPDOWN:            ;�׸� �̵��ϱ�
    gui,submit,nohide
    sendmessage,0x18B,,,listbox1, % title        ;�� �ټ�
    LB_GETCOUNT := errorlevel
    sendmessage,0x188,,,listbox1, % title            ;���ø���Ʈ ��ȣ ���
    ifequal,a_guicontrol,itemUP,ifequal,errorlevel,0,return
    ifequal,a_guicontrol,itemDN,ifequal,errorlevel,% LB_GETCOUNT-1,return
    LB_GETCURSEL := errorlevel
    sendmessage,0x182,LB_GETCURSEL,,listbox1, % title            ; ����Ʈ ����
    sendmessage,0x181,LB_GETCURSEL + (a_guicontrol="itemDN" ? 1:-1),"" . LB, listbox1, % title    ;�߰�
    sendmessage,0x186,LB_GETCURSEL + (a_guicontrol="itemDN" ? 1:-1),,listbox1, % title    ;����
    return
BTN20:
    reload
guiescape:
guiclose:
 exitapp