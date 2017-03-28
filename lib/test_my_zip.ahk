#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include Myzip.ahk
;~ MZ_UnzipAll( zipFilename, TargetPath, CreateTargetPath=1 
MiniZIP_Init( "Myzip.ahk" )
;~ packing
;~ zip := new ZipFile("MyZip.zip")
;~ ;// Add all text documents in the current directory to the archive and delete them
;~ zip.pack("temp", true)
;~ MZ_UnzipAll( "Myzip.zip", A_Temp )


return

;;it works