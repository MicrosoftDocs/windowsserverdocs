---
ms.assetid: c91c7196-ee0d-4856-8cfb-4c38494ccf1f
title: Work Folders overview
ms.technology: storage-work-folders
ms.topic: article
author: JasonGerend
manager: dougkim
ms.author: jgerend
ms.date: 06/15/2020
description: An overview of Work Folders - a server role in Windows Server that provides a consistent way for users to access work files from PCs and devices.
---
# Work Folders overview

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10, Windows 8.1, Windows 7

This topic discusses Work Folders, a role service for file servers running Windows Server that provides a consistent way for users to access their work files from their PCs and devices.

If you're looking to download or use Work Folders on Windows 10, Windows 7, or an Android or iOS device, see the following:

- [Work Folders for Windows 10](https://support.microsoft.com/help/12370/windows-10-work-folders)
- [Work Folders for Windows 7 (64 bit download)](https://www.microsoft.com/download/details.aspx?id=42558)
- [Work Folders for Windows 7 (32 bit download)](https://www.microsoft.com/download/details.aspx?id=42559)
- [Work Folders for iOS](https://itunes.apple.com/app/work-folders/id950878067)
- [Work Folders for Android](https://play.google.com/store/apps/details?id=com.microsoft.workfolders)

## Role description

 With Work Folders users can store and access work files on personal computers and devices, often referred to as bring-your-own device (BYOD), in addition to corporate PCs. Users gain a convenient location to store work files, and they can access them from anywhere. Organizations maintain control over corporate data by storing the files on centrally managed file servers, and optionally specifying user device policies such as encryption and lock-screen passwords.

 Work Folders can be deployed with existing deployments of Folder Redirection, Offline Files, and home folders. Work Folders stores user files in a folder on the server called a *sync share*. You can specify a folder that already contains user data, which enables you to adopt Work Folders without migrating servers and data or immediately phasing out your existing solution.

## Practical applications

 Administrators can use Work Folders to provide users with access to their work files while keeping centralized storage and control over the organization's data. Some specific applications for Work Folders include:

-   Provide a single point of access to work files from a user's work and personal computers and devices

-   Access work files while offline, and then sync with the central file server when the PC or device next has Internet or intranet connectivity

-   Deploy with existing deployments of Folder Redirection, Offline Files, and home folders

-   Use existing file server management technologies, such as file classification and folder quotas, to manage user data

-   Specify security policies to instruct user's PCs and devices to encrypt Work Folders and use a lock screen password

-   Use Failover Clustering with Work Folders to provide a high-availability solution

## Important functionality

 Work Folders includes the following functionality.

| Functionality | Availability | Description |
| ------------------- | ------------------ | ----------------- |
| Work Folders role service in Server Manager | Windows Server 2019, Windows Server 2016, or Windows Server 2012 R2 | File and Storage Services provides a way to set up sync shares (folders that store user's work files), monitors Work Folders, and manages sync shares and user access |
| Work Folders cmdlets | Windows Server 2019, Windows Server 2016, or Windows Server 2012 R2 | A Windows PowerShell module that contains comprehensive cmdlets for managing Work Folders servers |
| Work Folders integration with Windows | Windows 10<p> Windows 8.1<p> Windows RT 8.1<p> Windows 7 (download required) | Work Folders provides the following functionality in Windows computers:<p> -   A Control Panel item that sets up and monitors Work Folders<br />-   File Explorer integration that enables easy access to files in Work Folders<br />-   A sync engine that transfers files to and from a central file server while maximizing battery life and system performance |
| Work Folders app for devices | Android<p> Apple iPhone and iPad® | An app that allows popular devices to access files in Work Folders |

## New and changed functionality

The following table describes some of the major changes in Work Folders.

| Feature/functionality | New or updated? | Description |
| ---------------------------- | --------------------- | ----------------- |
| Improved logging | New in Windows Server 2019 | Event logs on the Work Folders server can be used to monitor sync activity and identify users that are failing sync sessions. Use Event ID 4020 in the Microsoft-Windows-SyncShare/Operational event log to identify which users are failing sync sessions. Use Event ID 7000 and Event ID 7001 in the Microsoft-Windows-SyncShare/Reporting event log to monitor users that are successfully completing upload and download sync sessions. |
| Performance counters | New in Windows Server 2019 | The following performance counters were added: Bytes downloaded/sec, Bytes uploaded/sec, Connected Users, Files downloaded/sec, Files uploaded/sec, Users with change detection, Incoming requests/sec and Outstanding requests. |
| Improved server performance | Updated in Windows Server 2019 | Performance improvements were made to handle more users per server. The limit per server varies and is based on the number of files and file churn. To determine the limit per server, users should be added to the server in phases. |
| On-demand file access | Added to Windows 10 version 1803 | Enables you to see and access all of your files. You control which files are stored on your PC and available offline. The rest of your files are always visible and don’t take up any space on your PC, but you need connectivity to the Work Folders file server to access them. |
| Azure AD Application Proxy support | Added to Windows 10 version 1703, Android, iOS | Remote users can securely access their files on the Work Folders server using Azure AD Application Proxy. |
| Faster change replication | Updated in Windows 10 and Windows Server 2016 | For Windows Server 2012 R2, when file changes are synced to the Work Folders server, clients are not notified of the change and wait up to 10 minutes to get the update. When using Windows Server 2016, the Work Folders server immediately notifies Windows 10 clients and the file changes are synced immediately. This capability is new in Windows Server 2016 and requires a Windows 10 client. If you're using an older client or the Work Folders server is Windows Server 2012 R2, the client will continue to poll every 10 minutes for changes. |
| Integrated with Windows Information Protection (WIP) | Added to Windows 10 version 1607 | If an administrator deploys WIP, Work Folders can enforce data protection by encrypting the data on the PC. The encryption is using a key associated with the Enterprise ID, which can be remotely wiped by using a supported mobile device management package such as Microsoft Intune. |

## Software requirements

Work Folders has the following software requirements for file servers and your network infrastructure:

-   A server running Windows Server 2019, Windows Server 2016, or Windows Server 2012 R2 for hosting sync shares with user files

-   A volume formatted with the NTFS file system for storing user files

-   To enforce password policies on Windows 7 PCs, you must use Group Policy password policies. You also have to exclude the Windows 7 PCs from Work Folders password policies (if you use them).

-   A server certificate for each file server that will host Work Folders. These certificates should be from a certification authority (CA) that is trusted by your users—ideally a public CA.

-   (Optional) An Active Directory Domain Services forest with the schema extensions in Windows Server 2012 R2 to support automatically referring PCs and devices to the correct file server when using multiple file servers.

To enable users to sync across the Internet, there are additional requirements:

-   The ability to make a server accessible from the Internet by creating publishing rules in your organization's reverse proxy or network gateway

-   (Optional) A publicly registered domain name and the ability to create additional public DNS records for the domain

-   (Optional) Active Directory Federation Services (AD FS) infrastructure when using AD FS authentication

Work Folders has the following software requirements for client computers:

-   PCs and devices must be running one of the following operating systems:

    -   Windows 10

    -   Windows 8.1

    -   Windows RT 8.1

    -   Windows 7

    -   Android 4.4 KitKat and later

    -   iOS 10.2 and later

-   Windows 7 PCs must be running one of the following editions of Windows:

    -   Windows 7 Professional

    -   Windows 7 Ultimate

    -   Windows 7 Enterprise

-   Windows 7 PCs must be joined to your organization's domain (they can't be joined to a workgroup).

-   Enough free space on a local, NTFS-formatted drive to store all the user's files in Work Folders, plus an additional 6 GB of free space if Work Folders is located on the system drive, as it is by default. Work Folders uses the following location by default: **%USERPROFILE%\Work Folders**

     However, users can change the location during setup (microSD cards and USB drives formatted with the NTFS file system are supported locations, though sync will stop if the drives are removed).

     The maximum size for individual files is 10 GB by default. There is no per-user storage limit, although administrators can use the quotas functionality of File Server Resource Manager to implement quotas.

-   Work Folders doesn't support rolling back the virtual machine state of client virtual machines. Instead perform backup and restore operations from inside the client virtual machine by using System Image Backup or another backup app.

## Work Folders compared to other sync technologies

The following table discusses how various Microsoft sync technologies are positioned and when to use each.

| | Work Folders | Offline Files | OneDrive for Business | OneDrive |
| - | ------------------ | ------------------- | -------------------------- | -------------- |
| **Technology summary** | Syncs files that are stored on a file server with PCs and devices | Syncs files that are stored on a file server with PCs that have access to the corporate network (can be replaced by Work Folders) | Syncs files that are stored in Office 365 or in SharePoint with PCs and devices inside or outside a corporate network, and provides document collaboration functionality | Syncs personal files that are stored in OneDrive with PCs, Mac computers, and devices |
| **Intended to provide user access to work files** | Yes | Yes | Yes | No |
| **Cloud service** | None | None | Office 365 | Microsoft OneDrive |
| **Internal network servers** | File servers running Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019 | File servers | SharePoint server (optional) | None |
| **Supported clients** | PCs, iOS, Android | PCs in a corporate network or connected through DirectAccess, VPNs, or other remote access technologies | PCs, iOS, Android, Windows Phone | PCs, Mac computers, Windows Phone, iOS, Android |

> [!NOTE]
>  In addition to the sync technologies listed in the previous table, Microsoft offers other replication technologies, including DFS Replication, which is designed for server-to-server replication, and BranchCache, which is designed as a branch office WAN acceleration technology. For more information, see [DFS Namespaces and DFS Replication](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj127250(v=ws.11)) and [BranchCache Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831696(v=ws.11))

## Server Manager information

Work Folders is part of the File and Storage Services role. You can install Work Folders by using the Add Roles and Features Wizard or the `Install-WindowsFeature` cmdlet. Both methods accomplish the following:

-   Adds the **Work Folders** page to **File and Storage Services** in Server Manager

-   Installs the Windows Sync Shares service, which is used by Windows Server to host sync shares

-   Installs the SyncShare Windows PowerShell module to manage Work Folders on the server

## Interoperability with Windows Azure virtual machines

 You can run this Windows Server role service on a virtual machine in Windows Azure. This scenario has been tested with Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019.

To learn about how to get started with Windows Azure virtual machines, visit the [Windows Azure web site](https://www.windowsazure.com/documentation/services/virtual-machines).

## See also

| Content type | References |
| ------------------ | ---------------- |
| **Product evaluation** | -   [Work Folders for Android – Released](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB) (blog post)<br />-   [Work Folders for iOS – iPad App Release](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB) (blog post)<br />-   [Introducing Work Folders on Windows Server 2012 R2](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB) (blog post)<br />-   [Introduction to Work Folders](https://channel9.msdn.com/posts/Introduction-to-Work-Folders) (Channel 9 Video)<br />-   [Work Folders Test Lab Deployment](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB) (blog post)<br />-   [Work Folders for Windows 7](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB) (blog post) |
| **Deployment** | -   [Designing a Work Folders Implementation](plan-work-folders.md)<br />-   [Deploying Work Folders](deploy-work-folders.md)<br />-   [Deploying Work Folders with AD FS and Web Application Proxy (WAP)](deploy-work-folders-adfs-overview.md)<br />-   [Deploying Work Folders with Azure AD Application Proxy](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB)<br />- [Offline Files (CSC) to Work Folders Migration Guide](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB)<br />-   [Performance Considerations for Work Folders Deployments](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB)<br />-   [Work Folders for Windows 7 (64 bit download)](https://www.microsoft.com/download/details.aspx?id=42558)<br />-   [Work Folders for Windows 7 (32 bit download)](https://www.microsoft.com/download/details.aspx?id=42559) |
| **Operations** | -   [Work Folders iPad app: FAQ](https://windows.microsoft.com/windows/work-folders-ipad-faq) (for users)<br />-   [Work Folders Certificate Management](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB) (blog post)<br />-   [Monitoring Windows Server 2012 R2 Work Folders Deployments](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB) (blog post)<br />-   [SyncShare (Work Folders) Cmdlets in Windows PowerShell](/powershell/module/syncshare/?view=win10-ps)<br />-   [Storage and File Services PowerShell Cmdlets Quick Reference Card For Windows Server 2012 R2 Preview Edition](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB) |
| **Troubleshooting** | -   [Windows Server 2012 R2 – Resolving Port Conflict with IIS Websites and Work Folders](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB) (blog post)<br />-   [Common Errors in Work Folders](https://techcommunity.microsoft.com/t5/storage-at-microsoft/troubleshooting-work-folders-on-windows-client/ba-p/425627) |
| **Community resources** | -   [File Services and Storage Forum](https://docs.microsoft.com/answers/topics/windows-server-storage.html)<br />-   [The Storage Team at Microsoft - File Cabinet Blog](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB)<br />-   [Ask the Directory Services Team Blog](/archive/blogs/askds/) |
| **Related technologies** | -   [Storage in Windows Server 2016](../storage.yml)<br>-   [File and Storage Services](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831487(v=ws.11))<br />-   [File Server Resource Manager](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831701(v=ws.11))<br />-   [Folder Redirection, Offline Files, and Roaming User Profiles](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh848267(v=ws.11))<br />-   [BranchCache](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831696(v=ws.11))<br />-   [DFS Namespaces and DFS Replication](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj127250(v=ws.11)) |
