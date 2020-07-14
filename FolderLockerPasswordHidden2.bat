cls 
@ECHO OFF 
title Folder Private 
if EXIST "HTG Locker" goto UNLOCK 
if NOT EXIST Private goto MDLOCKER 
:CONFIRM 
echo Are you sure you want to lock the folder(Y/N) 
set/p "cho=>" 
if %cho%==Y goto LOCK 
if %cho%==y goto LOCK 
if %cho%==n goto END 
if %cho%==N goto END 
echo Invalid choice. 
goto CONFIRM 
:LOCK 
ren Private "HTG Locker" 
attrib +h +s "HTG Locker" 
echo Folder locked 
goto End 


:UNLOCK 

::echo Enter password to unlock folder 
::set/p "pass=>" 

SetLocal EnableExtensions EnableDelayedExpansion

Set /P "=Password:" < Nul
Call :PasswordInput
Echo(Your input was:!Line!

if NOT !Line!== walkthegoodpath goto FAIL 
attrib -h -s "HTG Locker" 
ren "HTG Locker" Private 
echo Folder Unlocked successfully 
goto End 
:FAIL 
echo Invalid password 
goto end 
:MDLOCKER 
md Private 
echo Private created successfully 
goto End 
:End

Goto :Eof

:PasswordInput
::Author: Carlos Montiers Aguilera
::Last updated: 20150401. Created: 20150401.
::Set in variable Line a input password
For /F skip^=1^ delims^=^ eol^= %%# in (
'"Echo(|Replace.exe "%~f0" . /U /W"') Do Set "CR=%%#"
For /F %%# In (
'"Prompt $H &For %%_ In (_) Do Rem"') Do Set "BS=%%#"
Set "Line="
:_PasswordInput_Kbd
Set "CHR=" & For /F skip^=1^ delims^=^ eol^= %%# in (
'Replace.exe "%~f0" . /U /W') Do Set "CHR=%%#"
If !CHR!==!CR! Echo(&Goto :Eof
If !CHR!==!BS! (If Defined Line (Set /P "=!BS! !BS!" <Nul
Set "Line=!Line:~0,-1!"
)
) Else (Set /P "=*" <Nul
If !CHR!==! (Set "Line=!Line!^!"
) Else Set "Line=!Line!!CHR!"
)
Goto :_PasswordInput_Kbd

