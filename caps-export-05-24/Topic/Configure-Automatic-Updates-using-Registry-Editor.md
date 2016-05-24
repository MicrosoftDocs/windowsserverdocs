---
title: Configure Automatic Updates using Registry Editor
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 790788cb-9bf3-4a9e-9e71-08d7cfd9b801
author: britw
---
# Configure Automatic Updates using Registry Editor
If you do not want to use Group Policy to manage Automatic Updates \(for example, the WSUS deployment is in a non\-Active Directory environment\), you can configure Automatic Updates by using Registry Editor.  
  
> [!WARNING]  
> [!INCLUDE[Registry](../Token/Registry_md.md)]  
  
## Registry keys for configuring Automatic Updates  
Registry entries that you can use to configure Automatic Updates by using Registry Editor are located in the following subkeys:  
  
-   **HKEY\_LOCAL\_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WindowsUpdate**  
  
-   **HKEY\_CURRENT\_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer**  
  
-   **HKEY\_LOCAL\_MACHINE\\SYSTEM\\Internet Communication Management\\Internet Communication**  
  
-   **HKEY\_CURRENT\_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\WindowsUpdate**  
  
-   **HKEY\_LOCAL\_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU**  
  
### Registry keys for Windows Update  
WSUS registry entries for Windows Update are located in the following subkey:  
  
**HKEY\_LOCAL\_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WindowsUpdate**  
  
The keys and their values are listed in the following table.  
  
|Entry name|Data type|Values|  
|--------------|-------------|----------|  
|**AcceptTrustedPublisherCerts**|Reg\_DWORD|Range \= 1&#124;0<br /><br />-   1 \= Enabled. The WSUS server distributes available signed non\-Microsoft updates.<br />-   0 \= Disabled. The WSUS server does not distribute available signed non\-Microsoft updates.|  
|**DisableWindowsUpdateAccess**|Reg\_DWORD|Range \= 1&#124;0<br /><br />-   1 \= Disables access to Windows Update.<br />-   0 \= Enables access to Windows Update.|  
|**ElevateNonAdmins**|Reg\_DWORD|Range \= 1&#124;0<br /><br />-   1 \= All members of the Users security group can approve or disapprove updates.<br />-   0 \= Only members of the Administrators security group can approve or disapprove updates.|  
|**TargetGroup**|Reg\_SZ|Name of the computer group to which the computer belongs. This policy is paired with **TargetGroupEnabled**.|  
|**TargetGroupEnabled**|Reg\_DWORD|Range \= 1&#124;0<br /><br />-   1 \= Use client\-side targeting.<br />-   0 \= Do not use client\-side targeting. This policy is paired with **TargetGroup**.|  
|**WUServer**|Reg\_SZ|HTTP\(S\) URL of the WSUS server that is used by Automatic Updates and API callers \(by default\). This policy is paired with **WUStatusServer**, and both keys must be set to the same value to be valid.|  
|**WUStatusServer**|Reg\_SZ|The HTTP\(S\) URL of the server to which reporting information is sent for client computers that use the WSUS server that is configured by the **WUServer** key. This policy is paired with **WUServer**, and both keys must be set to the same value to be valid.|  
  
### WSUS registry keys for Internet Explorer  
WSUS registry entries for Internet Explorer are located in the following subkey:  
  
**HKEY\_CURRENT\_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer**  
  
The keys and their values are listed in the following table.  
  
|Entry name|Data type|Corresponding Group Policy setting|Values|  
|--------------|-------------|--------------------------------------|----------|  
|**NoWindowsUpdate**|Reg\_DWORD|**Remove links and access to Windows Update**|Prevents users from connecting to the Windows Update website.<br /><br />Range \= 1&#124;0<br /><br />-   1 \= Enabled. Users cannot connect to the Windows Update website.<br />-   0 \= Disabled or not configured. Users can connect to the Windows Update website.|  
  
### WSUS registry keys for Internet communication  
WSUS registry entries for Internet communication are located in the following subkey:  
  
**HKEY\_LOCAL\_MACHINE\\SYSTEM\\Internet Communication Management\\Internet Communication**  
  
The keys and their values are listed in the following table.  
  
|Entry name|Data type|Corresponding Group Policy setting|Values|  
|--------------|-------------|--------------------------------------|----------|  
|**DisableWindowsUpdateAccess**|Reg\_DWORD|**Turn off access to all Windows Update features**|Remove all access to Windows Update.<br /><br />Range \= 1&#124;0<br /><br />-   1 \= Enabled. All Windows Update features are removed. This includes blocking access to the Windows Update website at http:\/\/windowsupdate.microsoft.com, from the Windows Update hyperlink on the Start menu, and also on the Tools menu in Internet Explorer. Windows automatic updating is also disabled; you will neither be notified about nor will you receive critical updates from Windows Update. This setting also prevents Device Manager from automatically installing driver updates from the Windows Update website.<br />-   0 \= Disabled or not configured. Users will be able to access the Windows Update website and enable automatic updating to receive notifications and critical updates from Windows Update.|  
  
### WSUS registry key for Windows Update  
WSUS registry entry for Windows Update is located in the following subkey:  
  
**HKEY\_CURRENT\_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\WindowsUpdate**  
  
The key and its value is listed in the following table.  
  
|Entry name|Data type|Corresponding Group Policy setting|Values|  
|--------------|-------------|--------------------------------------|----------|  
|**DisableWindowsUpdateAccess**|Reg\_DWORD|**Remove access to use all Windows Update features**|Prevents users from connecting to the Windows Update website.<br /><br />Range \= 1&#124;0<br /><br />-   1 \= Enabled. All Windows Update features are removed.<br />-   0 \= Disabled or not configured. All Windows Update features are available.|  
  
### Registry keys for Automatic Update configuration options  
The registry entries for Automatic Update configuration options are located in the following subkey:  
  
**HKEY\_LOCAL\_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU**  
  
The keys and their values are listed in the following table.  
  
|Entry name|Data type|Values|  
|--------------|-------------|----------|  
|**AUOptions**|Reg\_DWORD|Range \= 2&#124;3&#124;4&#124;5<br /><br />-   2 \= Notify before download.<br />-   3 \= Automatically download and notify of installation.<br />-   4 \= Automatically download and schedule installation. Only valid if values exist for **ScheduledInstallDay** and **ScheduledInstallTime**.<br />-   5 \= Automatic Updates is required and users can configure it.|  
|**AutoInstallMinorUpdates**|Reg\_DWORD|Range \= 0&#124;1<br /><br />-   0 \= Treat minor updates like other updates.<br />-   1 \= Silently install minor updates.|  
|**DetectionFrequency**|Reg\_DWORD|Range \= n, where n \= time in hours \(1–22\).<br /><br />-   Time between detection cycles.|  
|**DetectionFrequencyEnabled**|Reg\_DWORD|Range \= 0&#124;1<br /><br />-   1 \= Enable detection frequency.<br />-   0 \= Disable custom detection frequency \(use default value of 22 hours\).|  
|**NoAutoRebootWithLoggedOnUsers**|Reg\_DWORD|Range \= 0&#124;1<br /><br />-   1 \= Logged\-on user can decide whether to restart the client computer.<br />-   0 \= Automatic Updates notifies the user that the computer will restart in 15 minutes.|  
|**NoAutoUpdate**|Reg\_DWORD|Range \= 0&#124;1<br /><br />-   0 \= Enable Automatic Updates.<br />-   1 \= Disable Automatic Updates.|  
|**RebootRelaunchTimeout**|Reg\_DWORD|Range \= n, where n \= time in minutes \(1–1,440\).<br /><br />-   Time between prompts for a scheduled restart.|  
|**RebootRelaunchTimeoutEnabled**|Reg\_DWORD|Range \= 0&#124;1<br /><br />-   1 \= Enable **RebootRelaunchTimeout**.<br />-   0 \= Disable custom **RebootRelaunchTimeout**\(use default value of 10 minutes\).|  
|**RebootWarningTimeout**|Reg\_DWORD|Range \= n, where n \= time in minutes \(1–30\).<br /><br />-   Length, in minutes, of the restart warning countdown after updates have been installed that have a deadline or scheduled updates.|  
|**RebootWarningTimeoutEnabled**|Reg\_DWORD|Range \= 0&#124;1<br /><br />-   1 \= Enable **RebootWarningTimeout**.<br />-   0 \= Disable custom **RebootWarningTimeout** \(use default value of 5 minutes\).|  
|**RescheduleWaitTime**|Reg\_DWORD|Range \= n, where n \= time in minutes \(1–60\).<br /><br />-   Time in minutes that Automatic Updates waits at startup before it applies updates from a missed scheduled installation time.<br />-   This policy applies only to scheduled installations, not to deadlines. Updates with deadlines that have expired should always be installed as soon as possible.|  
|**RescheduleWaitTimeEnabled**|Reg\_DWORD|Range \= 0&#124;1<br /><br />-   1 \= Enable **RescheduleWaitTime** .<br />-   0 \= Disable **RescheduleWaitTime** \(attempt the missed installation during the next scheduled installation time\).|  
|**ScheduledInstallDay**|Reg\_DWORD|Range \= 0&#124;1&#124;2&#124;3&#124;4&#124;5&#124;6&#124;7<br /><br />-   0 \= Every day.<br />-   1 through 7 \= the days of the week from Sunday \(1\) to Saturday \(7\).<br />    \(Only valid if **AUOptions** \= 4.\)|  
|**ScheduledInstallTime**|Reg\_DWORD|Range \= n, where n \= the time of day in 24\-hour format \(0–23\).|  
|**UseWUServer**|Reg\_DWORD|Range \= 0&#124;1<br /><br />-   1 \= The computer gets its updates from a WSUS server.<br />-   0 \= The computer gets its updates from Microsoft Update.<br />-   The **WUServer** value is not respected unless this key is set.|  
  
## See Also  
[Plan Automatic Updates settings](assetId:///f4aff13a-07f0-4939-881f-95191a025fcc)  
[Configure Automatic Updates using Group Policy](../Topic/Configure-Automatic-Updates-using-Group-Policy.md)  
  
