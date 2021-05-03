CD /d %LOCALAPPDATA%\chia-blockchain\app-1.1.1\resources\app.asar.unpacked\daemon\
REM ECHO OFF
REM PR = Parallel Run {1, 2, 3, etc)
REM TO = Timeout before start (of first run) for staggering
REM T1 = Tempfolder 1, T2 = Tempfolder 2, FF = Finalfolder
REM LF = LogFolder, LC = LogCycle (How many plots do you want to retain logs for), LI = Number of LogCycle
REM A following line is to have additional bytes in the batchfile prior to doing anything.
REM You can in fact alter the code while running the batch files. Once it is done with a plot, it'll read the next
REM command in the newly saved RunChiaPlot.bat **provided that** the next command (or any valid command) is still at the same byte-position
REM So if code added before the call of chia.exe (or if you cange that call and the length is altered)
REM use the star-line to adjust: Delete/add then number of characters you have added in code. Not sure about newline, I assume counts as 1 char.
REM ************************************************************************************************************************
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
:Run
CLS
SET /A LI=LI+1
IF %LI% GTR %LC% (SET /A LI=1)
SET SLI=%LI%
IF %LI% LSS 10 (SET SLI=0%LI%)
SET SPR=PR
IF %PR% LSS 10 (SET SPR=0%PR%)
SET LFN=%LF%\Plotter_%SPR%_L%SLI%.log
REM I delete the existing log file so that the NTFS attribute Date created is updated. Easier to determine start and end time (or in my case, date ROFL).
IF EXIST %LFN% (DEL %LFN%)
chia.exe plots create -k32 -b4500 -r2 -t%T1% -2%T2% -d%FF% >%LFN%
if exist "c:\chiatest\stop.txt" (
	goto :end
) else (
goto :Run
)
:End
ECHO Stop.txt was found, I ended.
Exit