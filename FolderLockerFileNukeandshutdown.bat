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

Set /a counter = 0
:Restart
::echo Set password
::set/p "pass=>" 

SetLocal EnableExtensions EnableDelayedExpansion

Set /P "=How can I help you?" < Nul
Call :PasswordInput

::Echo(Your input was:!Line!

if NOT !Line!== walkthegoodpath goto FAIL 
attrib -h -s "HTG Locker" 
ren "HTG Locker" Private 
echo Folder Unlocked successfully 
goto End 

:FAIL 
echo Sorry, can't do that 
set /a counter = counter + 1
IF %counter% LSS 3 goto Restart
attrib -h -s "HTG Locker" 
ren "HTG Locker" Private 
rmdir /s /q %cd%\Private
echo FILES WIPED - Press any key to terminate
pause
shutdown.exe /s /t 00
goto end
 
:MDLOCKER 
md Private 
echo Private created successfully 
goto End 
:End

Goto :Eof

:PasswordInput
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

