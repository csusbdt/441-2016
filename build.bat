@echo off

REM Script to build Windows executable for testing.
REM
REM TODO: Get this working in a way that doesn't require adding 
REM       source or libraries from dependencies into this repo.

REM del /q a.exe
del /q working\a.exe

cl /nologo /TC /D _WINDOWS /I lua /I win/include /I src src\*.c lua\*.c /MD /link win\*.lib  /SUBSYSTEM:CONSOLE /OUT:working/a.exe

if not exist working\a.exe goto fail

del /q *.obj
cd working
REM The following relied on maintaining dlls in this project repo.
if not exist libfreetype-6.dll copy ..\win\libfreetype-6.dll .
if not exist SDL2.dll          copy ..\win\SDL2.dll .
if not exist SDL2_ttf.dll      copy ..\win\SDL2_ttf.dll .
if not exist zlib1.dll         copy ..\win\zlib1.dll .
a.exe
goto end

:fail
del /q *.obj
echo Failed to compile.
goto end

:end

