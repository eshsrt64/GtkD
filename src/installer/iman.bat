@echo off

rem cleanup ####################
del *.map *.exe *.bak *.obj

echo.
echo         #####################################
echo         ### compile manager ###
echo         #####################################
echo.

rem compile ####################
cd ..
dmd -g -c -odinstaller -version=StandAlone -version=UI -I.;\DD\dante\dool\src installer\Manager.d
IF %ERRORLEVEL% GEQ 1 (
	cd installer
	goto failedComp
)

rem link #######################
:link

rem define libs ################
set GTK_BASE=\DD\dantfw\GTK\lib

set LIBS=dool+dui+phobos+kernel32+user32

rem +ADVAPI32+COMCTL32+COMDLG32+CTL3D32+gc+GDI32+KERNEL32+ODBC32+OLE32+OLEAUT32+RPCRT4+SHELL32+snn+USER32+UUID+WINMM+WINSPOOL+WSOCK32

rem set LIBS=%LIBS%+charset
rem set LIBS=%LIBS%+iconv
rem set LIBS=%LIBS%+intl
rem set LIBS=%LIBS%+jpeg62
set LIBS=%LIBS%+libatk-1
set LIBS=%LIBS%+libgdk-win32-2
set LIBS=%LIBS%+libgdk_pixbuf-2
set LIBS=%LIBS%+libglib-2
set LIBS=%LIBS%+libgmodule-2
set LIBS=%LIBS%+libgobject-2
set LIBS=%LIBS%+libgthread-2
set LIBS=%LIBS%+libgtk-win32-2
rem set LIBS=%LIBS%+libjpeg
set LIBS=%LIBS%+libpango-1
rem set LIBS=%LIBS%+libpangoft2-1
rem set LIBS=%LIBS%+libpangowin32-1
rem set LIBS=%LIBS%+libpng
rem set LIBS=%LIBS%+libtiff
rem set LIBS=%LIBS%+zlib1
rem set LIBS=%LIBS%+zlib

rem define lib dirs #############

set LIBS_BASE=\DD\dante\dool\ \DD\dante\DUI\ \DD\dmd\lib\ \DD\dm\lib\ 
set LIBS_BASE=%LIBS_BASE% %GTK_BASE%\ 


rem link ########################
@echo \DD\dm\bin\link.exe installer\Manager.obj, installer\DUIConfigMan.exe,, %LIBS%  %LIBS_BASE% 

\DD\dm\bin\link.exe installer\Manager.obj, installer\DUIConfigMan.exe,, %LIBS%  %LIBS_BASE% 
@IF %ERRORLEVEL% GEQ 1 (
	cd installer
	goto failedLink
)

@echo off

cd installer

set dest=\dantTemp

copy DUIConfigMan.exe %dest%

goto end


:failedComp
echo.
echo failed to compile
goto end

:failedLink
echo.
echo failed to LINK
goto end

:end