#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include %a_scriptdir%\minizip.ahk

SetWorkingDir %A_ScriptDir%
SplitPath, A_AhkPath,, A_AhkDir

7z_exe:="7z.exe"

7z_compress(dPack,files*) {
	global 7z_exe
	flist:=""
	for each, file in files
		flist:= flist """" file """" " "
	if FileExist(dPack)
		FileDelete, %dPack%
	RunWait, %7z_exe% a -t7z "%dPack%" %flist%,,Hide UseErrorLevel
	return !7z_error(ErrorLevel)
}

7z_extract(dPack,dFolder="",opts="") {
	global 7z_exe
	if StrLen(dFolder)
		out:="-o" . """" . dFolder . """"
	RunWait, %7z_exe% x "%dPack%" %out% -y %opts%,,Hide UseErrorLevel
	return !7z_error(ErrorLevel)
}

7z_list(dPack) {
	global 7z_exe
	tmp:=TempFile()
	RunWait,%comspec% /c %7z_exe% l "%dPack%" > "%tmp%",,Hide UseErrorLevel
	r:={}
	if (!(e:=7z_error(ErrorLevel))) {
		FileRead,o,%tmp%
		Loop, Parse, o, `n, `r
		{
			if (RegExMatch(A_LoopField,"(-+\s+){4}")) {
				if (!i)
					i:=A_Index
				else
					break
			}
			if (A_Index-i > 0) {
				p:=StrSplit(A_LoopField,A_Space)
				RegExMatch(SubStr(A_LoopField,StrLen(p.1 p.2 p.3)+3),"\d+",S)
				c:=InStr(A_LoopField,S)+StrLen(S)
				StringTrimLeft,n,A_LoopField,%c%
				
				k:={}
				k.Date := p.1
				k.Time := p.2
				k.Attr := p.3
				k.Size := S
				k.Name := RegExReplace(n,"\s+\d*\s+","","",1)
				
				r.Insert(k)
			}
		}
	}
	FileDelete,%tmp%
	return (e?0:r)
}

7z_error(e) {
	if (e==1)
		MsgBox Warning (Non fatal error(s)). For example, one or more files were locked by some other application, so they were not compressed. 
	else if (e==2)
		MsgBox Fatal error 
	else if (e==7)
		MsgBox Command line error 
	else if (e==8)
		MsgBox Not enough memory for operation 
	else if (e==255)
		MsgBox User stopped the process 
	return e
}

TempFile() {
	Loop
		tempName := A_Temp "\~temp" A_TickCount ".tmp"
	until !FileExist(tempName)
	return tempName
}

7z_compress(A_ScriptDir,"data.txt")



return