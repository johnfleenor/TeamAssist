@echo off

:: ========== Run Tests Script ==========
:: Takes a single argument: which tests to run
:: Example argument values:
:: *.lua             (runs all tests)
:: test_example.lua  (runs a specific test)

:: If your argument value is a file that is not a test file (test_*.lua),
:: the script will attempt to run the individual test file you most
:: recently executed. If it can't determine that, it will run all tests.

:: Run this script from the Decoda lua editor:
:: 1. Tools > External Tools > Add
:: 2. Title: Run Tests
:: 3. Command: <path_to_this_script>
:: 4. Arguments: $(ItemFileName).$(ItemExt)
:: 5. OK
:: You can set a keyboard shortcut to this via Tools > Settings

:: This script assumes %LUA_DEV% is your Lua install path
:: Lua for Windows does this for you when you install Lua
:: Download LfW: http://code.google.com/p/luaforwindows/ 

:: ==== Hopefully you won't have to edit below this line! ====

set TEST_FILES_INPUT=%1

:: Make sure Lua is in our %PATH%
if "%PATH%"=="" set PATH=%LUA_DEV%

:: Generate .user filename
set USER_DATA_FILENAME=%~n0.user

:: Change the working directory to the directory where this script lives
%~d0
cd %~d0%~p0

:: Determine which test(s) to execute based on user input
set defaultTestFilesShouldBeUsed=false
set testFilesInputIsSpecificTestFile=false
set userDataFileExists=false
if exist "%USER_DATA_FILENAME%" set userDataFileExists=true
if "%TEST_FILES_INPUT%"=="" set defaultTestFilesShouldBeUsed=true
if "%TEST_FILES_INPUT%"=="." set defaultTestFilesShouldBeUsed=true
if "%TEST_FILES_INPUT:~0,5%"=="test_" set testFilesInputIsSpecificTestFile=true
if "%testFilesInputIsSpecificTestFile%%userDataFileExists%"=="falsefalse" set defaultTestFilesShouldBeUsed=true

if "%defaultTestFilesShouldBeUsed%"=="true" (
    set TEST_FILES=*.lua
) else (
	if "%testFilesInputIsSpecificTestFile%"=="true" (
		set TEST_FILES=%TEST_FILES_INPUT%
	) else (
		:: read the last-executed test into %TEST_FILES%
		FOR /F "tokens=*" %%i IN (%USER_DATA_FILENAME%) DO set TEST_FILES=%%i
	)
)

:: Tell Lua what patterns to try when resolving 'require' statements (http://www.lua.org/pil/8.1.html)
set LUA_PATH=..\?.lua
:: Execute the %TEST_FILES%
for /f %%a IN ('dir /b /s %TEST_FILES%') do lua %%a

:: If we executed a specific test, write that to the .user file to read later
if "%testFilesInputIsSpecificTestFile%"=="true" echo %TEST_FILES% > %USER_DATA_FILENAME%

echo Parameter: %TEST_FILES_INPUT%
echo Executed : %TEST_FILES%