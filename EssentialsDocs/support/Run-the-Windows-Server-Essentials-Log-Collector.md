---
title: "Run the Windows Server Essentials Log Collector"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0d340223-fa24-4c75-ba8e-b654feb120ab
author: nnamuhcs
ms.author: coreyp
manager: dongill
---



# Run the Windows Server Essentials Log Collector
You can run the  Windows Server Essentials Log Collector from the server or a computer on the network. If you run the Log Collector from the server, you can only collect logs from the server. If you run the Log Collector from a network computer, you can choose to collect logs from the server, in addition to the logs for that computer.  
  
 You must have appropriate administrative privileges to run the Log Collector. If you are collecting log files for a server, you must be a Server Administrator; if you are collecting log files on a network computer, you must be a Client Administrator for that computer.  
  
#### To run the Log Collector on the server by using the wizard  
  
1. On the **Start** page of the server, click **Windows Server Essentials Log Collector**.  
  
   > [!NOTE]
   > - If the Log Collector program does not appear on the **Start** page, browse to **%system%\Program Files (x86)\Windows Server Essentials Log Collector**, and then double-click **LogCollector**.  
   >   -   If you are not logged on to the server with administrative privileges, the Log Collector prompts you to enter your credentials.  
  
2. When you are prompted for a location to save the collected log files, you can choose the default location, **\\\\<ServerName\>\logs**, or specify another location. To accept the default location, click **Next**. To change the location, click **Browse**, navigate to the folder where you want to save the log files, and then click **Save**.  
  
   > [!NOTE]
   >  You do not need to supply file names for the log files. The Log Collector names the zip file collection by concatenating the computer name and the time stamp of the file.  
  
3. A progress bar is displayed while the logs are being collected.  
  
4. To view the contents of the log collection file, select the **Open the file location where the logs were saved** check box, and click **Close** to close the wizard and open the log collection file.  
  
#### To run the Log Collector on a network computer by using the wizard  
  
1.  Browse to **%system%\Program Files (x86)\Windows Server Essentials Log Collector**, and then double-click the file **LogCollector.exe**.  
  
    > [!NOTE]
    >  If you are not logged on to the network computer with administrative privileges, enter your user name and password when prompted, and then click **Next**.  
  
2.  Select which logs you would like to collect, as follows:  
  
    1.  Select the **Server log files** check box to collect log files on the server.  
  
    2.  The **Client computer log files (this computer)** check box is selected by default, indicating that the Log Collector will collect the logs from the network computer that is running the. If you only want to collect server logs, clear the **Client computer log files (this computer)** check box.  
  
    3.  Click **Next**.  
  
3.  When prompted, type the user name and password for a server administrator, and then click **Next**.  
  
4.  Type or browse to the location where you want to save the log files, and then click **Next**.  
  
    > [!NOTE]
    >  You do not need to supply file names for the log files. The Log Collector names the zip file collection by concatenating the computer name and the time stamp of the file.  
  
5.  A progress bar is displayed while the logs are being collected.  
  
6.  To view the contents of the log collection file, select the **Open the file location where the logs were saved** check box, and click **Close** to close the wizard and open the log collection file.  
  
### Running the Log Collector manually  
 After the Log Collector is installed, a scheduled task is created to run the tool. You can subsequently run the Log Collector from the **Scheduled Task Manager** without using the wizard, if there are issues with starting the wizard.  
  
##### To manually run the Log Collector on the server  
  
1.  Log on directly or remotely to the server.  
  
2.  Open the **Task Scheduler**.  
  
3.  In the root of the **Task Scheduler Library**, browse to the scheduled task named **LogCollector**.  
  
4.  Right-click **LogCollector**, and then click **Run**. The Log Collector places the logs in the default folder on the server, **\\\\<ServerName\>\Logs**. If you do not have write permission for the folder, or the folder does not exist, logs are placed in the **<temp\>** subdirectory.  
  
##### To manually run the Log Collector on a network computer  
  
1.  Log on directly or remotely to the network computer.  
  
2.  Open the **Task Scheduler**.  
  
3.  In the root of the **Task Scheduler Library**, browse to the scheduled task named **LogCollector**.  
  
4.  Right-click **LogCollector**, and then click **Run**. The Log Collector places the logs in the **<temp\>** folder on the network computer.
