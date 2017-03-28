;;7z test

#include 7zip.ahk
SetWorkingDir, %A_ScriptDir%
;~ global 7z_exe
;~ 7z_exe:="7za.exe"

;~ to_save=% a_scriptdir . "sa.zip" ;7z_compress(dPack,files*) {
7z_compress("sdd.7z","temp")
;~ 7z_extract("myzip.7z","sdf")

	
	return