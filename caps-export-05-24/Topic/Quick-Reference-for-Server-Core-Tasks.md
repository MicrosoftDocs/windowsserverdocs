---
title: Quick Reference for Server Core Tasks
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 04efacdd-266a-4df2-a0f1-35f17ad137f0
author: jaimeo
---
# Quick Reference for Server Core Tasks
This topic is a collection of common administrative tasks for Server Core servers that you can perform locally or remotely from a command prompt.  
  
Whenever possible, Windows PowerShell commands are used and are styled thus: `Get-NetIPConfiguration`. When no Windows PowerShell equivalent is available, run the indicated command at an ordinary command prompt or a Windows PowerShell prompt. These command are styled thus: **Netdom remove**  
  
|Task|Description|  
|--------|---------------|  
|[1.1. Configuration and installation](../Topic/Quick-Reference-for-Server-Core-Tasks.md#BKMK_1.1)|Configuration and installation|  
|[1.2. Networking and firewall](../Topic/Quick-Reference-for-Server-Core-Tasks.md#BKMK_1.2)|Networking and firewall|  
|[1.3. Updates and error reporting](../Topic/Quick-Reference-for-Server-Core-Tasks.md#BKMK_1.3)|Updates and error reporting|  
|[1.4. Services, processes, and performance](../Topic/Quick-Reference-for-Server-Core-Tasks.md#BKMK_1.4)|Services, processes, and performance|  
|[1.5. Event logs](../Topic/Quick-Reference-for-Server-Core-Tasks.md#BKMK_1.5)|Event logs|  
|[1.6. Disk and file system](../Topic/Quick-Reference-for-Server-Core-Tasks.md#BKMK_1.6)|Disk and file system|  
|[1.7. Hardware](../Topic/Quick-Reference-for-Server-Core-Tasks.md#BKMK_1.7)|Hardware|  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="BKMK_1.1"></a>1.1. Configuration and installation  
  
|Task|Steps|  
|--------|---------|  
|Set the local administrative password|Run:<br /><br />**Net user administrator \***|  
|Join a computer to a domain|Run `Add-Computer`<br /><br />For more information see [Configure a Server Core Server](../Topic/Configure-a-Server-Core-Server.md)|  
|Confirm that the domain has changed|Run:<br /><br />**set**|  
|Remove a computer from a domain|Run:<br /><br />`Remove-Computer`|  
|Add a user to the local Administrators group.|Run:<br /><br />**net localgroup Administrators \/add <domain>\\<username>**|  
|Remove a user from the local Administrators group|Run:<br /><br />**net localgroup Administrators \/delete <domain\\username>**|  
|Add a user to the local computer|Run:<br /><br />**net user <domain\\user name> \/add \***|  
|Add a group to the local computer|Run:<br /><br />**net localgroup <group name> \/add**|  
|Change the name of a domain\-joined computer|Run `Rename-Computer`|  
|Confirm the new computer name|Run:<br /><br />**set c**|  
|Change the name of a computer in a work group|Run:<br /><br />`Rename-Computer`|  
|Disable paging file management|Run:<br /><br />**wmic computersystem where name\="<computername>" set AutomaticManagedPagefile\=False**|  
|Configure the paging file|Run:<br /><br />**wmic pagefileset where name\=”<path\/filename>” set InitialSize\=<initialsize>,MaximumSize\=<maxsize>**<br /><br />Where:<br /><br />*path\/filename* is the path to and name of the paging file<br /><br />*initialsize* is the starting size of the paging file in bytes<br /><br />*maxsize* is the maximum size of the paging file in bytes|  
|Change to a static IP address|See [http:\/\/technet.microsoft.com\/library\/hh826123](http://technet.microsoft.com/library/hh826123).|  
|Set a static DNS address|See [http:\/\/technet.microsoft.com\/library\/hh826123](http://technet.microsoft.com/library/hh826123).|  
|Change to a DHCP\-provided IP address from a static IP address|See [http:\/\/technet.microsoft.com\/library\/hh826123](http://technet.microsoft.com/library/hh826123).|  
|Enter a product key|Run `slmgr.vbs –ipk <product key>`, and then run `slmgr.vbs –ato`. For more information, see [Configure a Server Core Server](../Topic/Configure-a-Server-Core-Server.md).|  
|Activate the server locally|Run **slmgr.vbs \-ato**|  
|Activate the server remotely|1.  Run **cscript slmgr.vbs –ipk <product key><server name><username><password>**<br />2.  Run **cscript slmgr.vbs \-ato <servername> <username> <password>**<br />3.  Retrieve the GUID of the computer with cscript **slmgr.vbs \-did**<br />4.  Run **cscript slmgr.vbs \-dli <GUID>**<br />5.  Verify that **License status** is set to **Licensed \(activated\)**.|  
  
> [!NOTE]  
> If Slmgr.vbs fails to activate the computer, the resulting error message advises you to run Slui.exe, along with the error code for more information. Slui.exe is not included in Server Core installations—it is available in <versions>.  
  
## <a name="BKMK_1.2"></a>1.2. Networking and firewall  
  
|Task|Steps|  
|--------|---------|  
|Configure your server to use a proxy server.|Run **netsh Winhttp set proxy <servername>:<port number>** **Note:** Servers in Server Core mode cannot access the Internet through a proxy that requires a password to allow connections.|  
|Configure your server to bypass the proxy for Internet addresses.|Run **netsh winttp set proxy <servername>:<port number>bypass\-list\="<local>"**|  
|Display or modify IPSEC configuration.|Run **netsh ipsec**|  
|Display or modify NAP configuration.|Run **netsh nap**|  
|Display or modify IP\-to\-physical address translation.|Run **arp**|  
|Display or configure the local routing table.|Run **route**|  
|View or configure DNS server settings.|Run **nslookup**|  
|Display protocol statistics and current TCP\/IP network connections|Run **netstat**|  
|Display protocol statistics and current TCP\/IP connections using NetBIOS over TCP\/IP \(NBT\).|Run **nbtstat**|  
|Display hops for network connections.|Run **pathping**|  
|Trace hops for network connections.|Run **tracert**|  
|Display the configuration of the multicast router|Run **mrinfo**|  
|Enable remote administration of the firewall.|Run **netsh advfirewall firewall set rule group\=”Windows Firewall Remote Management” new enable\=yes**|  
  
> [!NOTE]  
> See additional Windows PowerShell cmdlets for networking at [http:\/\/technet.microsoft.com\/library\/hh826123](http://technet.microsoft.com/library/hh826123), [http:\/\/technet.microsoft.com\/library\/jj134956](http://technet.microsoft.com/library/jj134956), and [http:\/\/technet.microsoft.com\/library\/hh848620](http://technet.microsoft.com/library/hh848620).  
  
## <a name="BKMK_1.3"></a>1.3. Updates and error reporting  
  
|Task|Steps|  
|--------|---------|  
|Install an update|Run **wusa <update>.msu \/quiet**|  
|List installed updates|Run **systeminfo**|  
|Remove an update|1.  Run **expand \/f:\* <update>.msu c:\\test**<br />2.  Navigate to c:\\test\\ and open <update>.xml in a text editor.<br />3.  In <update>.xml, replace **Install** with **Remove** and save the file.<br />4.  Run **pkgmgr \/n:<update>.xml**|  
|Configure automatic updates|-   To verify the current setting, run **cscript scregedit.wsf \/AU \/v**<br />-   To enable automatic updates, run **cscript scregedit.wsf \/AU 4**<br />-   To disable automatic updates, run **cscript scregedit.wsf \/AU 1**|  
|Enable error reporting|-   To verify the current setting, run **serverWerOptin \/query**<br />-   To automatically send detailed reports, run **serverWerOptin \/detailed**<br />-   To automatically send summary reports, run **serverWerOptin \/summary**<br />-   To disable error reporting, run **serverWerOptin \/disable**|  
|Participate in the Customer Experience Improvement Program \(CEIP\)|-   To verify the current setting, run **serverCEIPOptin \/query**<br />-   To enable CEIP, run **serverCEIPOptin \/enable**<br />-   To disable CEIP, run **serverCEIPOptin \/disable**|  
  
## <a name="BKMK_1.4"></a>1.4. Services, processes, and performance  
  
|Task|Steps|  
|--------|---------|  
|List running services|Run `Get-Service`|  
|Start a service|Run `Start-Service`|  
|Stop a service|Run `Stop-Service`|  
|Retrieve a list of running applications and associated processes|See [http:\/\/technet.microsoft.com\/library\/dd347650.aspx](http://technet.microsoft.com/library/dd347650.aspx).|  
|Stop a process forcibly|See [http:\/\/technet.microsoft.com\/library\/dd347650.aspx](http://technet.microsoft.com/library/dd347650.aspx).|  
|Start Task Manager|Run **taskmgr**|  
|Manage the performance counters and logging with commands such as **typeperf**, **logman**, **relog**, **tracerprt**.|See [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=84872](http://go.microsoft.com/fwlink/?LinkId=84872).|  
  
## <a name="BKMK_1.5"></a>1.5. Event logs  
Use `Get-EventLog` and related cmdlets; see [http:\/\/technet.microsoft.com\/library\/ee176846](http://technet.microsoft.com/library/ee176846).  
  
## <a name="BKMK_1.6"></a>1.6. Disk and file system  
  
|Task|Steps|  
|--------|---------|  
|Manage disk partitions|For a complete list of commands, run **diskpart \/?**|  
|Manage software RAID|For a complete list of commands, run **diskraid \/?**|  
|Manage volume mount points|For a complete list of commands, run **mountvol \/?**|  
|Defragment a volume|For a complete list of commands, run **defrag \/?**|  
|Convert a volume to the NTFS file system|Run **convert <volume letter> \/FS:NTFS**|  
|Compact a file|For a complete list of commands, run **compact \/?**|  
|Administer open files|For a complete list of commands, run **openfiles \/?**|  
|Administer VSS folders|For a complete list of commands, run **vssadmin \/?**|  
|Administer the file system|For a complete list of commands, run **fsutil \/?**|  
|Verify a file signature|For a complete list of commands, run **sigverif \/?**|  
|Take ownership of a file or folder|For a complete list of commands, run **icacls \/?**|  
  
## <a name="BKMK_1.7"></a>1.7. Hardware  
  
|Task|Steps|  
|--------|---------|  
|Add a driver for a new hardware device|1.  Copy the driver to a folder at %homedrive%\\<driver folder>.<br />2.  Run **pnputil \-i \-a %homedrive%\\<driver folder>\\<driver>.inf**|  
|Remove a driver for a hardware device|1.  Obtain a list of loaded drivers by running **sc query type\= driver**<br />2.  Run **sc delete <service\_name>**|  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Service Updates on a Server Core Server](../Topic/Service-Updates-on-a-Server-Core-Server.md)  
  
-   [Configure and Manage Server Core Installations](../Topic/Configure-and-Manage-Server-Core-Installations.md)  
  
-   [Windows Server Installation Options](../Topic/Windows-Server-Installation-Options.md)  
  
-   [Evaluation Versions and Upgrade Options for Windows Server 2012](http://go.microsoft.com/fwlink/?LinkId=260917)  
  
-   [Windows PowerShell Support for Windows Server 2012](http://technet.microsoft.com/library/hh801904)  
  
