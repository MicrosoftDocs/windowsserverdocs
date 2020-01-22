---
title: Folder Redirection, Offline Files, and Roaming User Profiles overview
description: An overview of Folder Redirection, Offline Files, and Roaming User Profiles technologies.
ms.prod: windows-server 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage 
ms.date: 04/05/2018
ms.localizationpriority: medium
---
# Folder Redirection, Offline Files, and Roaming User Profiles overview

>Applies to: Windows 10, Windows 8, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012, Windows Server 2012 R2

This topic discusses the Folder Redirection, Offline Files (client-side caching or CSC), and Roaming User Profiles (sometimes known as RUP) technologies, including what's new and where to find additional information.

## Technology description

Folder Redirection and Offline Files are used together to redirect the path of local folders (such as the Documents folder) to a network location, while caching the contents locally for increased speed and availability. Roaming User Profiles is used to redirect a user profile to a network location. These features used to be referred to as Intellimirror.

- **Folder Redirection** enables users and administrators to redirect the path of a known folder to a new location, manually or by using Group Policy. The new location can be a folder on the local computer or a directory on a file share. Users interact with files in the redirected folder as if it still existed on the local drive. For example, you can redirect the Documents folder, which is usually stored on a local drive, to a network location. The files in the folder are then available to the user from any computer on the network.
- **Offline Files** makes network files available to a user, even if the network connection to the server is unavailable or slow. When working online, file access performance is at the speed of the network and server. When working offline, files are retrieved from the Offline Files folder at local access speeds. A computer switches to Offline Mode when:
  - **Always Offline** mode has been enabled
  - The server is unavailable
  - The network connection is slower than a configurable threshold
  - The user manually switches to Offline Mode by using the **Work offline** button in Windows Explorer
- **Roaming User Profiles** redirects user profiles to a file share so that users receive the same operating system and application settings on multiple computers. When a user signs in to a computer by using an account that is set up with a file share as the profile path, the user's profile is downloaded to the local computer and merged with the local profile (if present). When the user signs out of the computer, the local copy of their profile, including any changes, is merged with the server copy of the profile. Typically, a network administrator enables Roaming User Profiles on domain accounts.

## Practical applications

Administrators can use Folder Redirection, Offline Files, and Roaming User Profiles to centralize storage for user data and settings and to provide users with the ability to access their data while offline or in the event of a network or server outage. Some specific applications include:

- Centralize data from client computers for administrative tasks, such as using a server-based backup tool to back up user folders and settings.
- Enable users to continue accessing network files, even if there is a network or server outage.
- Optimize bandwidth usage and enhance the experience of users in branch offices who access files and folders that are hosted by corporate servers located offsite.
- Enable mobile users to access network files while working offline or over slow networks.

## New and changed functionality

The following table describes some of the major changes in Folder Redirection, Offline Files, and Roaming User Profiles that are available in this release.

| Feature/functionality | New or updated? | Description |
| --- | --- | --- |
| Always Offline mode | New | Provides faster access to files and lower bandwidth usage by always working offline, even when connected through a high-speed network connection. |
| Cost-aware synchronization | New | Helps users avoid high data usage costs from synchronization while using metered connections that have usage limits, or while roaming on another provider's network. |
| Primary Computer support | New | Enables you to limit the use of Folder Redirection, Roaming User Profiles, or both to only a user's primary computers. |

## Always Offline mode

Starting with Windows 8 and Windows Server 2012, administrators can configure the experience for users of Offline Files to always work offline, even when they are connected through a high-speed network connection. Windows updates files in the Offline Files cache by synchronizing hourly in the background, by default.

### What value does Always Offline mode add?

The Always Offline mode provides the following benefits:

- Users experience faster access to files in redirected folders, such as the Documents folder.
- Network bandwidth is reduced, decreasing costs on expensive WAN connections or metered connections such as a 4G mobile network.

### How has Always Offline mode changed things?

Prior to Windows 8, Windows Server 2012, users would transition between the Online and Offline modes, depending on network availability and conditions, even when the Slow-Link mode (also known as the Slow Connection mode) was enabled and set to a 1 millisecond latency threshold.

With Always Offline mode, computers never transition to Online mode when the **Configure slow-link mode** Group Policy setting is configured and the **Latency** threshold parameter is set to 1 millisecond. Changes are synced in the background every 120 minutes, by default, but synchronization is configurable by using the **Configure Background Sync** Group Policy setting.

For more information, see [Enable the Always Offline Mode to Provide Faster Access to Files](enable-always-offline.md).

## Cost-aware synchronization

With cost-aware synchronization, Windows disables background synchronization when the user is using a metered network connection, such as a 4G mobile network, and the subscriber is near or over their bandwidth limit, or roaming on another provider's network.

> [!NOTE]
> Metered network connections usually have round-trip network latencies that are slower than the default 35 millisecond latency value for transitioning to Offline (Slow Connection) mode in Windows 8, Windows Server 2019, Windows Server 2016, and Windows Server 2012. Therefore, these connections usually transition to Offline (Slow Connection) mode automatically.

### What value does cost-aware synchronization add?

Cost-aware synchronization helps users avoid unexpectedly high data usage costs while using metered connections that have usage limits, or while roaming on another provider's network.

### How has cost-aware synchronization changed things?

Prior to Windows 8 and Windows Server 2012, users who wanted to minimize fees while using Offline Files on metered network connections had to track their data usage by using tools from the mobile network provider. The users could then manually switch to Offline mode when they were roaming, near their bandwidth limit, or over their limit.

With cost-aware sync, Windows automatically tracks roaming and bandwidth usage limits while on metered connections. When the user is roaming, near their bandwidth limit, or over their limit, Windows switches to Offline mode and prevents all synchronization. Users can still manually initiate synchronization, and administrators can override cost-aware synchronization for specific users, such as executives.

For more information, see [Enable Background File Synchronization on Metered Networks](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj127408(v%3dws.11)).

## Primary computers for Folder Redirection and Roaming User Profiles

You can now designate a set of computers, known as primary computers, for each domain user, which enables you to control which computers use Folder Redirection, Roaming User Profiles, or both. Designating primary computers is a simple and powerful method to associate user data and settings with particular computers or devices, simplify administrator oversight, improve data security, and help protect user profiles from corruption.

### What value do primary computers add?

There are four major benefits to designating primary computers for users:

- The administrator can specify which computers users can use to access their redirected data and settings. For example, the administrator can choose to roam user data and settings between a user's desktop and laptop, and to not roam the information when that user logs on to any other computer, such as a conference room computer.
- Designating primary computers reduces the security and privacy risk of leaving residual personal or corporate data on computers where the user has logged on. For example, a general manager who logs on to an employee's computer for temporary access does not leave behind any personal or corporate data.
- Primary computers enable the administrator to mitigate the risk of an improperly configured or otherwise corrupt profile, which could result from roaming between differently configured systems, such as between x86-based and x64-based computers.
- The amount of time required for a user's first sign-in on a non-primary computer, such as a server, is faster because the user's roaming user profile and/or redirected folders are not downloaded. Sign-out times are also reduced, because changes to the user profile do not need to be uploaded to the file share.

### How have primary computers changed things?

To limit downloading private user data to primary computers, the Folder Redirection and Roaming User Profiles technologies perform the following logic checks when a user signs in to a computer:

1. The Windows operating system checks the new Group Policy settings (**Download roaming profiles on primary computers only** and **Redirect folders on primary computers only**) to determine if the **msDS-Primary-Computer** attribute in Active Directory Domain Services (AD DS) should influence the decision to roam the user's profile or apply Folder Redirection.
2. If the policy setting enables primary computer support, Windows verifies that the AD DS schema supports the **msDS-Primary-Computer** attribute. If it does, Windows determines if the computer that the user is logging on to is designated as a primary computer for the user as follows:
    1. If the computer is one of the user's primary computers, Windows applies the Roaming User Profiles and Folder Redirection settings.
    2. If the computer is not one of the user's primary computers, Windows loads the user's cached local profile, if present, or it creates a new local profile. Windows also removes any existing redirected folders according to the removal action that was specified by the previously applied Group Policy setting, which is retained in the local Folder Redirection configuration.

For more information, see [Deploy Primary Computers for Folder Redirection and Roaming User Profiles](deploy-primary-computers.md)

## Hardware requirements

Folder Redirection, Offline Files, and Roaming User Profiles require an x64-based or x86-based computer, and they are not supported by Windows on ARM (WOA)-based computers.

## Software requirements

To designate primary computers, your environment must meet the following requirements:

- The Active Directory Domain Services (AD DS) schema must be updated to include Windows Server 2012 schema and conditions (installing a Windows Server 2012 or later domain controller automatically updates the schema). For more information about upgrading the AD DS schema, see [Upgrade Domain Controllers to Windows Server 2016](../../identity/ad-ds/deploy/upgrade-domain-controllers.md).
- Client computers must run Windows 10, Windows 8.1, Windows 8, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012 and be joined to the Active Directory domain that you are managing.

## More information

For additional related information, see the following resources.

| Content type | References |
| --- | --- |
| Product evaluation | [Supporting Information Workers with Reliable File Services and Storage](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831495(v%3dws.11)>)<br>[What's New in Offline Files](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff183315(v=ws.10)>) (Windows 7 and Windows Server 2008 R2)<br>[What's New in Offline Files for Windows Vista](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-vista/cc749449(v=ws.10)>)<br>[Changes to Offline Files in Windows Vista](<https://technet.microsoft.com/library/2007.11.offline.aspx>) (TechNet Magazine) |
| Deployment | [Deploy Folder Redirection, Offline Files, and Roaming User Profiles](deploy-folder-redirection.md)<br>[Implementing an End-User Data Centralization Solution: Folder Redirection and Offline Files Technology Validation and Deployment](https://download.microsoft.com/download/3/0/1/3019A3DA-2F41-4F2D-BBC9-A6D24C4C68C4/Implementing%20an%20End-User%20Data%20Centralization%20Solution.docx)<br>[Managing Roaming User Data Deployment Guide](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-vista/cc766489(v=ws.10)>)<br>[Configuring New Offline Files Features for Windows 7 Computers Step-by-Step Guide](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff633429(v=ws.10)>)<br>[Using Folder Redirection](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753996(v=ws.11)>)<br>[Implementing Folder Redirection](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2003/cc737434(v=ws.10)>) (Windows Server 2003) |
| Tools and settings | [Offline files on MSDN](https://msdn.microsoft.com/library/cc296092.aspx)<br>[Offline Files Group Policy Reference](https://msdn.microsoft.com/library/ms878937.aspx) (Windows 2000) |
| Community resources | [File Services and Storage Forum](https://social.technet.microsoft.com/forums/windowsserver/home?forum=winserverfiles)<br>[Hey, Scripting Guy! How Can I Work with the Offline Files Feature in Windows?](<https://blogs.technet.microsoft.com/heyscriptingguy/2009/06/02/hey-scripting-guy-how-can-i-enable-and-disable-offline-files/>)<br>[Hey, Scripting Guy! How Can I Enable and Disable Offline Files?](<https://blogs.technet.microsoft.com/heyscriptingguy/2009/06/02/hey-scripting-guy-how-can-i-enable-and-disable-offline-files/>) |
| Related technologies|[Identity and Access in Windows Server](../../identity/identity-and-access.md)<br>[Storage in Windows Server](../storage.md)<br>[Remote access and server management](../../remote/index.md) |