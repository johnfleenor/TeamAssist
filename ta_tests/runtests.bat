@echo off

:: To run this script from the Decoda lua editor, create an "External Tool"
:: which takes this script as its "Command" and the following "Arguments":
:: C:\Progra~2\Lua\5.1\ $(ItemFileName).$(ItemExt)

:: What directory did you install Lua in?
set LUA_INSTALL_PATH=C:\Program Files (x86)\Lua\5.1\

:: Hopefully you won't have to edit below this line!

set PATH=%1
if "%PATH%"=="" set PATH=%LUA_INSTALL_PATH%

set TEST_FILES_INPUT=%2

:: User data filename
set USER_DATA_FILENAME=%~n0.user

%~d0
cd %~d0%~p0

:: http://www.lua.org/pil/8.1.html
set LUA_PATH=..\?.lua

:: What test files should be executed?
if "%TEST_FILES_INPUT%"=="." (
    set TEST_FILES=*.lua
) else (
    if "%TEST_FILES_INPUT:~0,5%"=="test_" (
		set TEST_FILES=%TEST_FILES_INPUT%
	) else (
		FOR /F "tokens=*" %%i IN (%USER_DATA_FILENAME%) DO set TEST_FILES=%%i
	)
)

echo Executing: %TEST_FILES%

:: Execute the %TEST_FILES%
for /f %%a IN ('dir /b /s %TEST_FILES%') do lua %%a

if "%TEST_FILES_INPUT:~0,5%"=="test_" echo %TEST_FILES% > %USER_DATA_FILENAME%