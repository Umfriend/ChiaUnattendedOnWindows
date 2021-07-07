ECHO OFF
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
REM For testing, k is now set through StartUpChia.bat
SET PR=%1
SET /A TO=%2
SET /A KF=%3
SET T1=%4
SET T2=%5
SET FF=%6
SET LF=%7
SET /A LC=%8
SET /A LI=0
SET /A TR=1
ECHO Gonna wait for %TO%
TIMEOUT /t %TO% >NUL
DEL %T1%\*.* /F /Q
DEL %T2%\*.* /F /Q
:Run
CD /d %LOCALAPPDATA%\chia-blockchain\app-1.1.6\resources\app.asar.unpacked\daemon\
CLS
DATE /T & TIME /T
ECHO Running Plot %TR%
SET /A LI=LI+1
REM --FOR TEST --
REM IF %LI% GTR 2 (goto :end)
REM --FOR TEST --
IF %LI% GTR %LC% (SET /A LI=1)
SET SLI=%LI%
IF %LI% LSS 10 (SET SLI=0%LI%)
SET SPR=%PR%
IF %PR% LSS 10 (SET SPR=0%PR%)
SET LFN=%LF%\Plotter_%SPR%_L%SLI%.log
REM I delete the existing log file so that the NTFS attribute Date created is updated. Easier to determine start and end time (or in my case, date ROFL).
ECHO Checking and Deleting %LFN%
ECHO ON
IF EXIST %LFN% (
ECHO File %LFN% Exists.
DEL %LFN%
) ELSE (
ECHO File %LFN% does not exist.
TIMEOUT /t 1 >NUL
)
ECHO OFF
TIMEOUT /t 10 >NUL
chia.exe plots create -k%KF% -b4000 -r4 -t%T1% -2%T2% -d%FF% >%LFN%
SET /A TR=TR+1
if exist "c:\chiatest\plot.stop" (
	goto :end
) else (
goto :Run
)
:End
ECHO File Plot.stop was found, I ended.
Exit