;;minizip_test
#include minizip.ahk

;~ File1 := A_AhkDir "\AutoHotkey.exe"
;~ File2 := A_AhkDir "\License.txt"

;~ MiniZIP_Init( "minizip.dll" )

;~ hZip := MZ_ZipCreate( "ahkm.zip" )
        ;~ MZ_ZipAddFile( hZip, File1, "AHK/AutoHotkey.exe" )
        ;~ MZ_ZipAddFile( hZip, File2, "AHK/License.txt" )
        ;~ MZ_ZipClose( hZip )
		
		
		;~ SetWorkingDir %A_ScriptDir%
;~ MiniZIP_Init( "minizip.dll" )

;~ ; Unzipping all
;~ MZ_UnzipAll( "ahk.zip", A_Temp )

;~ ; Unzipping a single file
;~ zipFileNumber := MZ_ZipGetFileNumber( "ahkm.zip", "AHK/License.txt" )
;~ MZ_UnzipFileToDisk( "ahkm.zip", zipFileNumber, A_ScriptDir "\" )
SetWorkingDir %A_ScriptDir%
SplitPath, A_AhkPath,, A_AhkDir

File1 := A_AhkDir "\AutoHotkey.exe"
File2 := A_AhkDir "\License.txt"

MiniZIP_Init( "minizip.ahk" )

hZip := MZ_ZipCreate( "ahkm.zip" )
        MZ_ZipAddFile( hZip, File1, "AHK/AutoHotkey.exe" )
        MZ_ZipAddFile( hZip, File2, "AHK/License.txt" )
        MZ_ZipClose( hZip )

return
