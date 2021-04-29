CD /d %LOCALAPPDATA%\chia-blockchain\app-1.1.1\resources\app.asar.unpacked\daemon\
REM ECHO OFF
REM PR = Parallel Run {1, 2, 3, etc)
REM TO = Timeout before start (of first run) for staggering
REM T1 = Tempfolder 1, T2 = Tempfolder 2, FF = Finalfolder
REM LF = LogFolder, LC = LogCycle (How many plots do you want to rretina logs for), LI = Number of LogCycle
SET PR=%1
SET /A TO=%2 
SET T1=%3
SET T2=%4
SET FF=%5
SET LF=%6
SET /A LC=%7
SET /A LI=0
ECHO Gonna wait for %TO%
TIMEOUT /t %TO% >NUL
DEL %T1%\*.* /F /Q
DEL %T2%\*.* /F /Q
:RunIt
CLS
SET /A LI=LI+1
IF %LI% GTR %LC% (SET /A LI=1)
SET SLI=LI
IF %LI% LSS 10 (SET SLI=0%LI%)
SET SPR=PR
IF %PR% LSS 10 (SET SPR=0%PR%)
SET LFN=%LF%\Plotter_%SPR%_L%SLI%.log
chia.exe plots create -k32 -b4500 -r2 -t%T1% -2%T2% -d%FF% >%LFN%
if exist "c:\chiatest\stop.txt" (
	goto :end
) else (
goto :RunIt
)
:End
ECHO Stop.txt was found, I ended.
Exit