---
title: prncnfg
description: Learn how to configure a printer using the prncfg command.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 38a4e8fa-3122-495b-a125-35b926bc6415
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/11/2018
---
# prncnfg

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Configures or displays configuration information about a printer.

## Syntax
```
cscript Prncnfg {-g | -t | -x | -?} [-S <ServerName>] [-P <printerName>] [-z <NewprinterName>] [-u <UserName>] [-w <Password>] [-r <PortName>] [-l <Location>] [-h <Sharename>] [-m <Comment>] [-f <SeparatorFileName>] [-y <Datatype>] [-st <starttime>] [-ut <Untiltime>] [-i <DefaultPriority>] [-o <Priority>] [<+|->shared] [<+|->direct] [<+|->hidden] [<+|->published] [<+|->rawonly] [<+|->queued] [<+|->enablebidi] [<+|->keepprintedjobs] [<+|->workoffline] [<+|->enabledevq] [<+|->docompletefirst]
```

## Parameters
|Parameter|Description|
|-------|--------|
|-g|Displays configuration information about a printer.|
|-t|Configures a printer.|
|-x|renames a printer.|
|-S \<ServerName\>|Specifies the name of the remote computer that hosts the printer that you want to manage. If you do not specify a computer, the local computer is used.|
|-P \<printerName\>|Specifies the name of the printer that you want to manage. Required.|
|-z \<NewprinterName\>|Specifies the new printer name. Requires the **-x** and **-P** parameters.|
|-u \<UserName\> -w \<Password\>|Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you do not specify an account, you must be logged on under an account with these permissions for the command to work.|
|-r \<PortName\>|Specifies the port where the printer is connected. If this is a parallel or a serial port, then use the ID of the port (for example, LPT1 or COM1). If this is a TCP/IP port, use the port name that was specified when the port was added.|
|-l \<Location\>|Specifies the printer location, such as "copy Room."|
|-h \<Sharename\>|Specifies the printer's share name.|
|-m \<Comment\>|Specifies the printer's comment string.|
|-f \<SeparatorFileName\>|Specifies a file that contains the text that appears on the separator page.|
|-y \<Datatype\>|Specifies the data types that the printer can accept.|
|-st \<starttime\>|Configures the printer for limited availability. Specifies the time of day the printer is available. If you send a document to a printer when it is unavailable, the document is held (spooled) until the printer becomes available. You must specify time as a 24-hour clock. For example, to specify 11:00 P.M., type **2300**.|
|-ut \<Endtime\>|Configures the printer for limited availability. Specifies the time of day the printer is no longer available. If you send a document to a printer when it is unavailable, the document is held (spooled) until the printer becomes available. You must specify time as a 24-hour clock. For example, to specify 11:00 P.M., type **2300**.|
|-o \<Priority\>|Specifies a priority that the spooler uses to route print jobs into the print queue. A print queue with a higher priority receives all its jobs before any queue with a lower priority.|
|-i \<DefaultPriority\>|Specifies the default priority assigned to each print job.|
|{+&#124;-}shared|Specifies whether this printer is shared on the network.|
|{+&#124;-}direct|Specifies whether the document should be sent directly to the printer without being spooled.|
|{+&#124;-}published|Specifies whether this printer should be published in active directory. If you publish the printer, other users can search for it based on its location and capabilities (such as color printing and stapling).|
|{+&#124;-}hidden|Reserved function.|
|{+&#124;-}rawonly|Specifies whether only raw data print jobs can be spooled in this queue.|
|{+ &#124; -}queued|Specifies that the printer should not begin to print until after the last page of the document is spooled. The printing program is unavailable until the document has finished printing. However, using this parameter ensures that the whole document is available to the printer.|
|{+ &#124; -}keepprintedjobs|Specifies whether the spooler should retain documents after they are printed. Enabling this option allows a user to resubmit a document to the printer from the print queue instead of from the printing program.|
|{+ &#124; -}workoffline|Specifies whether a user is able to send print jobs to the print queue if the computer is not connected to the network.|
|{+ &#124; -}enabledevq|Specifies whether print jobs that do not match the printer setup (for example, PostScript files spooled to non-PostScript printers) should be held in the queue rather than being printed.|
|{+ &#124; -}docompletefirst|Specifies whether the spooler should send print jobs with a lower priority that have completed spooling before sending print jobs with a higher priority that have not completed spooling. If this option is enabled and no documents have completed spooling, the spooler will send larger documents before smaller ones. You should enable this option if you want to maximize printer efficiency at the cost of job priority. If this option is disabled, the spooler always sends higher priority jobs to their respective queues first.|
|{+ &#124; -}enablebidi|Specifies whether the printer sends status information to the spooler.|
|/?|Displays help at the command prompt.|

## Remarks
-   The **prncnfg** command is a Visual Basic script located in the %WINdir%\System32\printing_Admin_Scripts\\<language> directory. To use this command, at a command prompt, type **cscript** followed by the full path to the prncnfg file, or change directories to the appropriate folder. For example:
    ```
    cscript %WINdir%\System32\printing_Admin_Scripts\en-US\prncnfg
    ```
-   if the information that you supply contains spaces, use quotation marks around the text (for example, `"computer Name"`).

## <a name="BKMK_examples"></a>Examples
To display configuration information for the printer named colorprinter_2 with a print queue hosted by the remote computer named HRServer, type:
```
cscript prncnfg -g -S HRServer -P colorprinter_2 
```

To configure a printer named colorprinter_2 so that the spooler in the remote computer named HRServer keeps print jobs after they have been printed, type:
```
cscript prncnfg -t -S HRServer -P colorprinter_2 +keepprintedjobs 
```

To change the name of a printer on the remote computer named HRServer from colorprinter_2 to colorprinter 3, type:
```
cscript prncnfg -x -S HRServer -P colorprinter_2 -z "colorprinter 3" 
```

#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[print Command Reference](print-command-reference.md)
