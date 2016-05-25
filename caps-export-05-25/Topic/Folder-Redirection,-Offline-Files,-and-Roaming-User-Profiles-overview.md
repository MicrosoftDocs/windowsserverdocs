---
title: Folder Redirection, Offline Files, and Roaming User Profiles overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 168639ac-f8b4-4b57-ab43-19f8ae9ec487
author: JasonGerend
---
# Folder Redirection, Offline Files, and Roaming User Profiles overview
This topic discusses the Folder Redirection, Offline Files \(client\-side caching or CSC\), and Roaming User Profiles \(sometimes known as RUP\) technologies, including what’s new in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and where to find additional information.  
  
## Did you mean…  
  
-   [Offline Files and Folder Redirection](http://technet.microsoft.com/library/gg277982.aspx) \([!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]\)  
  
-   [Work Folders Overview](../Topic/Work-Folders-Overview.md)  
  
-   [BranchCache Overview](assetId:///a92ec0b2-eb08-4fe7-b6a6-d140e0f55fd5)  
  
## <a name="overview"></a>Technology description  
Folder Redirection and Offline Files are used together to redirect the path of local folders \(such as the Documents folder\) to a network location, while caching the contents locally for increased speed and availability. Roaming User Profiles is used to redirect a user profile to a network location. These features used to be referred to as Intellimirror.  
  
-   **Folder Redirection** enables users and administrators to redirect the path of a known folder to a new location, manually or by using Group Policy. The new location can be a folder on the local computer or a directory on a file share. Users interact with files in the redirected folder as if it still existed on the local drive. For example, you can redirect the Documents folder, which is usually stored on a local drive, to a network location. The files in the folder are then available to the user from any computer on the network.  
  
-   **Offline Files** makes network files available to a user, even if the network connection to the server is unavailable or slow. When working online, file access performance is at the speed of the network and server. When working offline, files are retrieved from the Offline Files folder at local access speeds. A computer switches to Offline Mode when:  
  
    -   The new *Always Offline* mode has been enabled  
  
    -   The server is unavailable  
  
    -   The network connection is slower than a configurable threshold  
  
    -   The user manually switches to Offline Mode by using the **Work offline** button in Windows Explorer  
  
-   **Roaming User Profiles** redirects user profiles to a file share so that users receive the same operating system and application settings on multiple computers. When a user signs in to a computer by using an account that is set up with a file share as the profile path, the user’s profile is downloaded to the local computer and merged with the local profile \(if present\). When the user signs out of the computer, the local copy of their profile, including any changes, is merged with the server copy of the profile. Roaming User Profiles is typically enabled on domain accounts by a network administrator.  
  
## <a name="user"></a>Practical applications  
Administrators can use Folder Redirection, Offline Files, and Roaming User Profiles to centralize storage for user data and settings and to provide users with the ability to access their data while offline or in the event of a network or server outage. Some specific applications include:  
  
-   Centralize data from client computers for administrative tasks, such as using a server\-based backup tool to back up user folders and settings.  
  
-   Enable users to continue accessing network files, even if there is a network or server outage.  
  
-   Optimize bandwidth usage and enhance the experience of users in branch offices who access files and folders that are hosted by corporate servers located offsite.  
  
-   Enable mobile users to access network files while working offline or over slow networks.  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
The following table describes some of the major changes in Folder Redirection, Offline Files, and Roaming User Profiles that are available in this release.  
  
|Feature\/functionality|New or updated?|Description|  
|--------------------------|-------------------|---------------|  
|Always Offline mode|New|Provides faster access to files and lower bandwidth usage by always working offline, even when connected through a high\-speed network connection.|  
|Cost\-aware synchronization|New|Helps users avoid high data usage costs from synchronization while using metered connections that have usage limits, or while roaming on another provider’s network.|  
|Primary Computer support|New|Enables you to limit the use of Folder Redirection, Roaming User Profiles, or both to only a user’s primary computers.|  
  
### Always Offline mode  
In [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], administrators can configure the experience for users of Offline Files to always work offline, even when they are connected through a high\-speed network connection. Windows updates files in the Offline Files cache by synchronizing hourly in the background, by default.  
  
**What value does this change add?**  
  
The Always Offline mode provides the following benefits:  
  
-   Users experience faster access to files in redirected folders, such as the Documents folder.  
  
-   Network bandwidth is reduced, decreasing costs on expensive WAN connections or metered connections such as a 4G mobile network.  
  
**What works differently?**  
  
Prior to [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], users would transition between the Online and Offline modes, depending on network availability and conditions, even when the Slow\-Link mode \(also known as the Slow Connection mode\) was enabled and set to a 1 millisecond latency threshold.  
  
With Always Offline mode, computers running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] never transition to Online mode when the **Configure slow\-link mode** Group Policy setting is configured and the **Latency** threshold parameter is set to 1 millisecond. Changes are synced in the background every 120 minutes, by default, but synchronization is configurable by using the **Configure Background Sync** Group Policy setting.  
  
For more information, see [Enable the Always Offline Mode to Provide Faster Access to Files](../Topic/Enable-the-Always-Offline-Mode-to-Provide-Faster-Access-to-Files.md).  
  
### Cost\-aware synchronization  
With cost\-aware synchronization, Windows disables background synchronization when the user is using a metered network connection, such as a 4G mobile network, and the subscriber is near or over their bandwidth limit, or roaming on another provider’s network.  
  
> [!NOTE]  
> Metered network connections usually have round\-trip network latencies that are slower than the default 35 millisecond latency value for transitioning to Offline \(Slow Connection\) mode in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Therefore, these connections usually transition to Offline \(Slow Connection\) mode automatically.  
  
**What value does this change add?**  
  
Cost\-aware synchronization helps users avoid unexpectedly high data usage costs while using metered connections that have usage limits, or while roaming on another provider’s network.  
  
**What works differently?**  
  
Prior to [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], users who wanted to minimize fees while using Offline Files on metered network connections had to track their data usage by using tools from the mobile network provider. The users could then manually switch to Offline mode when they were roaming, near their bandwidth limit, or over their limit.  
  
In [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows automatically tracks roaming and bandwidth usage limits while on metered connections. When the user is roaming, near their bandwidth limit, or over their limit, Windows switches to Offline mode and prevents all synchronization. Users can still manually initiate synchronization, and administrators can override cost\-aware synchronization for specific users, such as executives.  
  
For more information, see [Enable Background File Synchronization on Metered Networks](../Topic/Enable-Background-File-Synchronization-on-Metered-Networks.md).  
  
### Primary computers for Folder Redirection and Roaming User Profiles  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can designate a set of computers, known as primary computers, for each domain user, which enables you to control which computers use Folder Redirection, Roaming User Profiles, or both. Designating primary computers is a simple and powerful method to associate user data and settings with particular computers or devices, simplify administrator oversight, improve data security, and help protect user profiles from corruption.  
  
**What value does this change add?**  
  
There are four major benefits to designating primary computers for users:  
  
-   The administrator can specify which computers users can use to access their redirected data and settings. For example, the administrator can choose to roam user data and settings between a user’s desktop and laptop, and to not roam the information when that user logs on to any other computer, such as a conference room computer.  
  
-   Designating primary computers reduces the security and privacy risk of leaving residual personal or corporate data on computers where the user has logged on. For example, a general manager who logs on to an employee’s computer for temporary access does not leave behind any personal or corporate data.  
  
-   Primary computers enable the administrator to mitigate the risk of an improperly configured or otherwise corrupt profile, which could result from roaming between differently configured systems, such as between x86\-based and x64\-based computers.  
  
-   The amount of time required for a user’s first sign\-in on a non\-primary computer, such as a server, is faster because the user’s roaming user profile and\/or redirected folders are not downloaded. Sign\-out times are also reduced, because changes to the user profile do not need to be uploaded to the file share.  
  
**What works differently?**  
  
To limit downloading private user data to primary computers, the Folder Redirection and Roaming User Profiles technologies perform the following logic checks when a user signs in to a computer:  
  
1.  The Windows operating system checks the new Group Policy settings \(**Download roaming profiles on primary computers only** and **Redirect folders on primary computers only**\) to determine if the **msDS\-Primary\-Computer** attribute in Active Directory Domain Services \(AD DS\) should influence the decision to roam the user’s profile or apply Folder Redirection.  
  
2.  If the policy setting enables primary computer support, Windows verifies that the AD DS schema supports the **msDS\-Primary\-Computer** attribute. If it does, Windows determines if the computer that the user is logging on to is designated as a primary computer for the user as follows:  
  
    1.  If the computer is one of the user’s primary computers, Windows applies the Roaming User Profiles and Folder Redirection settings.  
  
    2.  If the computer is not one of the user’s primary computers, Windows loads the user’s cached local profile, if present, or it creates a new local profile. Windows also removes any existing redirected folders according to the removal action that was specified by the previously applied Group Policy setting, which is retained in the local Folder Redirection configuration.  
  
For more information, see [Deploy Primary Computers for Folder Redirection and Roaming User Profiles](../Topic/Deploy-Primary-Computers-for-Folder-Redirection-and-Roaming-User-Profiles.md)  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
Folder Redirection, Offline Files, and Roaming User Profiles require an x64\-based or x86\-based computer, and they are not supported by Windows on ARM \(WOA\)\-based computers.  
  
## <a name="BKMK_SOFT"></a>Software requirements  
To designate primary computers, your environment must meet the following requirements:  
  
-   The Active Directory Domain Services \(AD DS\) schema must be updated to include [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] schema additions \(installing a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] domain controller automatically updated the schema\). For information about updating the AD DS schema, see [What’s new for Adprep.exe?](../Topic/What-s-New-in-Active-Directory-Domain-Services-Installation-and-Removal.md#BKMK_NewAdprep) and [Running Adprep.exe](http://technet.microsoft.com/library/dd464018.aspx).  
  
-   Client computers must run [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and be joined to the Active Directory domain that you are managing.  
  
## <a name="BKMK_LINKS"></a>See also  
For additional related information, see the following resources.  
  
|Content type|References|  
|----------------|--------------|  
|**Product evaluation**|[Supporting Information Workers with Reliable File Services and Storage](../Topic/Supporting-Information-Workers-with-Reliable-File-Services-and-Storage.md) &#124; [What's New in Offline Files](http://technet.microsoft.com/library/ff183315.aspx) \(Windows 7 and Windows Server 2008 R2\) &#124; [What's New in Offline Files for Windows Vista](http://technet.microsoft.com/library/cc749449.aspx) &#124; [Changes to Offline Files in Windows Vista](http://technet.microsoft.com/magazine/2007.11.offline.aspx) \(TechNet Magazine\)|  
|**Deployment**|[Deploy Folder Redirection, Offline Files, and Roaming User Profiles](../Topic/Deploy-Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles.md) &#124; [Implementing an End\-User Data Centralization Solution: Folder Redirection and Offline Files Technology Validation and Deployment](http://go.microsoft.com/fwlink/?LinkID=168195) &#124; [Managing Roaming User Data Deployment Guide](http://technet.microsoft.com/library/cc766489.aspx) &#124; [Configuring New Offline Files Features for Windows 7 Computers Step\-by\-Step Guide](http://technet.microsoft.com/library/ff633429.aspx) &#124; [Using Folder Redirection](http://technet.microsoft.com/library/cc753996.aspx) &#124; [Implementing Folder Redirection](http://technet.microsoft.com/library/cc737434.aspx) \(Windows Server 2003\)|  
|**Tools and settings**|[Primary Computer Windows PowerShell cmdlets](http://archive.msdn.microsoft.com/PrimaryComputer) &#124; [Offline Files on MSDN](http://msdn.microsoft.com/library/cc296092.aspx) &#124; [Offline Files Group Policy Reference](http://msdn.microsoft.com/library/ms878937.aspx) \(Windows 2000\)|  
|**Community resources**|[File Services and Storage Forum](http://social.technet.microsoft.com/Forums/windowsserver/home?forum=winserverfiles) &#124; [Hey, Scripting Guy\! How Can I Work with the Offline Files Feature in Windows?](http://blogs.technet.com/b/heyscriptingguy/archive/2009/06/02/how-can-i-work-with-the-offline-files-feature-in-windows.aspx) &#124; [Hey, Scripting Guy\! How Can I Enable and Disable Offline Files?](http://blogs.technet.com/b/heyscriptingguy/archive/2009/06/03/how-can-i-enable-and-disable-offline-files.aspx)|  
|**Related technologies**|[Active Directory Domain Services Overview](../Topic/Active-Directory-Domain-Services-Overview.md) &#124; [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md) &#124; [Remote Desktop Services Overview](../Topic/Remote-Desktop-Services-Overview.md)|  
  
