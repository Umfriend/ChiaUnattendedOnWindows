DATE /T
TIME /T
START "Daemon" /b %LOCALAPPDATA%\chia-blockchain\app-1.1.1\resources\app.asar.unpacked\daemon\chia.exe start all
START "Plotter1" /b /normal C:\ChiaTest\BatchFiles\RunChiaPlotv2.bat 1 30 H:\Chia\TempPlots R:\Chia\TempPlots\Plot01 Y:\Chia\FinalPlots C:\ChiaTest\PlotLogs 10 ^>C:\ChiaTest\BatchLogs\Plot01.log 2>&1
START "Plotter2" /b /normal C:\ChiaTest\BatchFiles\RunChiaPlotv2.bat 2 1800 I:\Chia\TempPlots R:\Chia\TempPlots\Plot02 Y:\Chia\FinalPlots C:\ChiaTest\PlotLogs 10 ^>C:\ChiaTest\BatchLogs\Plot02.log 2>&1
START "Plotter3" /b /normal C:\ChiaTest\BatchFiles\RunChiaPlotv2.bat 3 3600 J:\Chia\TempPlots R:\Chia\TempPlots\Plot03 Y:\Chia\FinalPlots C:\ChiaTest\PlotLogs 10 ^>C:\ChiaTest\BatchLogs\Plot03.log 2>&1
START "Plotter4" /b /normal C:\ChiaTest\BatchFiles\RunChiaPlotv2.bat 4 5400 S:\Chia\TempPlots R:\Chia\TempPlots\Plot04 Y:\Chia\FinalPlots C:\ChiaTest\PlotLogs 10 ^>C:\ChiaTest\BatchLogs\Plot04.log 2>&1
TIMEOUT /t 120 >NUL
%LOCALAPPDATA%\chia-blockchain\app-1.1.1\resources\app.asar.unpacked\daemon\chia.exe stop timelord-only
if exist c:\ChiaTest\Stop.txt (
	CD /d C:\ChiaTest
	ren Stop.txt Stop.tyt)
ECHO "DONE!"
Exit