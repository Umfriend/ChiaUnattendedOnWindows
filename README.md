# ChiaUnattendedOnWindows
Batch file project to run Chia (plotting) unattended
Thanks to the dude on the Keybase chia.network channel who suggested to make it paramaterised. I don't know his name :( but he posted this link https://pastebin.com/i9wsbF1Z). Of course , it turned out to be a lot more complicated but it got me started. Managed to lose about 4 plots during testing ;)
**Why does it do what it does**
So I have this headless Server and I had some HDDs left and wanted to plot&farm Chia. At first I tried the GUI but it requires you to stay logged on (through e.g. RDP). Not what I want. Then I went to CLI but encountered the same issue. Even if I’d let it run by staying logged on, any reboot would stop the process.
I wanted to address that.

**What does it do**
A batch file, ChiaStartUp.bat, is started at boot-time, no log-on required. This batch file starts the node/farm and then starts a number instances of another batch file, RunChiaPlot.bat, each running a plot:
    Starts a plot
    If a plot finishes, it will do another ad infinitum.
    If a certain file is found, stop when finished with the current plot. This is basically a switch that you control (see near end)
    If a reboot has occurred, it will empty out the temporary folders / unfinished plots
    Puts logging for all in log files at a location of your choice.

**What do I need to use this**
You need to be able to schedule a task through Task Scheduler;
prepare folders for temporary and finished plotting files and for the batch/log files themselves
Be able to make some simple adjustments to the batch files through Notepad

**So what do I do**
We need a location for our batch and log files. I use C:\ChiaTest but you can change this. Choose a location, create it and amend the batch file (search&replace). You also want an empty file called “stop.tyt” in that folder. Within that folder you want BatchFiles, BatchLogs and PlotLogs as subfolders.
    
Create folders for the temporary files. With me, they are at \Chia\TempPlots in various drives (H:, I:, J:, R: and S:). Your locations will differ. One thing is important: **Each batch needs his own folders. If you, for instance, use a single SSD and plot to SSD:\Chia\TempPlots, then it will all fail. Instead you should have SSD:\Chia\Templots\Plot1, SSD:\Chia\Templots\Plot2 etc.** This is because the batch delete temporary files as, if and when e.g. a reboot mid-plotting has occurred. Each batch clears the temp plot location so the 2nd batch would clear files that the 1st batch is working on.

After editing the batchfiles, store them in your “C:\ChiaTest\BatchFiles” folder. 

Finally, you need to add a task through Task Scheduler:
    7.1. I named it Chia. Whatever.
    7.2. Trigger: At system startup
    7.3. Actions:
    7.3.1.Action: Start a program
    7.3.2.Program/script: C:\ChiaTest\BatchFiles\StartUpChia.bat
    7.3.3.Add arguments: >C:\ChiaTest\BatchLogs\StartUpChia.log 2>&1
    7.3.4.Start in: C:\ChiaTest\BatchFiles
    7.4. Of course, the C:\ChiaTest part must be amended to the location of your choice for the batch and log files.

    Reboot

Does it work?
After reboot, RDP into the machine. You should find StartUpChia.log, Plotxx.log in the BatchLogs folder and Plotter_xx_yy.log in the PlotLogs folder.
StartUpChia.log is the start-up log. It should tell you that daemon, the node, farmer etc have started.
Plotxx.log is the log of the iterating batch file, not much to be seen here.
Plotter_xx_Lyy.log is the actual log of the Plotter (output that is shown on the CLI if you’d use that).
xx = Plotter number
yy = Log cycle. It'll be clear if you look at the batch files

You can also look at task manager, details to see if the chia.exe processes cause I/O (column I/O write bytes) remember, at first only one run). If you show the Command line column, you can find see the .bat and chia jobs

What if I want a regular stop?
In your C:\ChiaTest folder, rename Stop.tyt to Stop.txt. Each batch file will terminate when its current plot process is finished. Then you can do whatever is needed (e.g. install software/updates and reboot. The whole process should start again. No need to rename Sotp.txt to Stop.tyt, the batch files do that at boot time.

Q&A
- Isn't there a better/easier way to do all this? I am sure. One could even make a real program (a service that arranges all this based on some config file and a GUI that can communicate with the service/plots and show logs/performance etc) but I cannot.
- How much in error handling do these do? Not much, if anything.
