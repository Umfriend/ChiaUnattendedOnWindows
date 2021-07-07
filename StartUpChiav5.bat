DATE /T
TIME /T
REM diskpart /s "C:\ChiaTest\BatchFiles\MountVHDs.bat
timeout /t 75 >NUL
START "Daemon" /b %LOCALAPPDATA%\chia-blockchain\app-1.1.6\resources\app.asar.unpacked\daemon\chia.exe start farmer
DEL C:\ChiaTest\BatchLogs\Plot*.* /F /Q
timeout /t 30 >NUL
REM START "Plotter1" /b /normal C:\ChiaTest\BatchFiles\RunChiaPlotv5.bat 1  1 32 K:\Chia\TempPlots H:\Chia\TempPlots\Plot01 Y:\Chia\FinalPlots C:\ChiaTest\PlotLogs 10 ^>C:\ChiaTest\BatchLogs\Plot01.log 2>&1
REM START "Plotter3" /b /normal C:\ChiaTest\BatchFiles\RunChiaPlotv5.bat 2  1 32 L:\Chia\TempPlots I:\Chia\TempPlots\Plot02 Y:\Chia\FinalPlots C:\ChiaTest\PlotLogs 10 ^>C:\ChiaTest\BatchLogs\Plot02.log 2>&1
REM START "Plotter2" /b /normal C:\ChiaTest\BatchFiles\RunChiaPlotv5.bat 2  3601 32 M:\Chia\TempPlots H:\Chia\TempPlots\Plot02 Y:\Chia\FinalPlots C:\ChiaTest\PlotLogs 10 ^>C:\ChiaTest\BatchLogs\Plot02.log 2>&1
if exist c:\ChiaTest\Plot.stop (
	CD /d C:\ChiaTest
	ren Plot.stop Plot.continue)
ECHO "DONE!"
Exit