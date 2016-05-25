---
title: Event ID 36 — Local Time Synchronization
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d94d6ada-11d3-4c6d-b886-b37dba5f4057
---
# Event ID 36 — Local Time Synchronization
The Windows Time service \(W32time\) synchronizes local time with a time source. The Windows Time service on a domain controller can be configured as either a reliable or an unreliable time source. The Windows Time service running on a client will attempt to synchronize its time source with servers that are indicated as being reliable. The Windows Time service can configure a domain controller within its domain as a reliable time source, and it synchronizes itself periodically with this source.  
  
## Event Details  
The event information is shown in the following table.  
  
|||  
|-|-|  
|Product|Windows Operating System|  
|ID|36|  
|Source|Microsoft\-Windows\-Time\-Service|  
|Version|6.1|  
|Symbolic Name|MSG\_TIME\_SOURCE\_NONE|  
|Message|The time service has not synchronized the system time for *<number>* seconds because none of the time service providers provided a usable time stamp. The time service is no longer synchronized and cannot provide the time to other clients or update the system clock. Monitor the system events displayed in the Event Viewer to make sure that a more serious problem does not exist.|  
  
## Resolution  
The Windows Time service cannot contact a valid time source. This Event ID 36 may indicate a network connectivity issue or a problem with the time source. Perform the following procedure on the computer that is logging the event to be resolved.  
  
To perform this procedure, you must have membership in **Administrators**, or you must have been delegated the appropriate authority.  
  
#### To resynchronize the Windows Time service with the time source  
  
1.  Open a command prompt as an administrator. To open a command prompt as an administrator, click **Start**. Type **Command Prompt**. At the top of the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  At the command prompt, type **w32tm \/resync**, and then press ENTER. The command output indicates whether the synchronization was successful.  
  
If the previous steps do not resolve the issue, verify network connectivity to the time source, and then check the time source for malfunctions.  
  
## Verify  
To perform this procedure, you must have membership in **Administrators**, or you must have been delegated the appropriate authority.  
  
#### To verify that the Windows Time service is synchronizing correctly  
  
1.  Open a command prompt as an administrator. To open a command prompt as an administrator, click **Start**. Type **Command Prompt**. At the top of the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  At the command prompt, type W32TM \/resync, and then press ENTER.  
  
3.  At the command prompt, type **W32TM \/query \/status**, and then press ENTER. The command displays the status of the Windows Time service synchronization. The Last Successful Sync Time line of the output displays the date and time that you ran the W32TM \/resync command in the previous step. Also, check the computer name that is shown as the Source. This should be the name of a domain controller \(or administrator\-configured time server\).  
  
    To confirm that the Windows Time service was synchronized successfully with its time source when you ran the W32TM \/resync command, verify that Event ID 35 appears in the Event Viewer.  
  
## See Also  
[Windows Time Service Technical Reference](http://go.microsoft.com/fwlink/?LinkID=25393)  
  
