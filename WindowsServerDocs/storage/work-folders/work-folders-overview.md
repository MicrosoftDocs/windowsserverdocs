---
ms.assetid: c91c7196-ee0d-4856-8cfb-4c38494ccf1f
title: Work Folders overview
ms.topic: conceptual
author: JasonGerend
manager: femila
ms.author: jgerend
ms.date: 03/22/2023
description: Learn how Work Folders provides a consistent way for users to access work files from PCs and devices in Windows.
---

# Work Folders overview

>**Applies To:** Windows 11, Windows 10, Windows Server 2022, Windows Server 2019, Windows Server 2016

Work Folders is a Windows Server role service for file servers. Work Folders provides a consistent way for users to access their work files from their PCs and devices. For older versions, see [Other versions of Work Folders](#other-versions-of-work-folders).

With Work Folders, users can store and access work files on personal computers and devices, often referred to as bring-your-own device (BYOD), in addition to corporate PCs. Users gain a convenient location to store work files, and they can access those files from anywhere. Organizations use Work Folders to help maintain control over corporate data. They can store files on centrally managed file servers and define user device policies such as encryption and lock-screen passwords.

You can deploy Work Folders with existing deployments of Folder Redirection, Offline Files, and home folders. Work Folders stores user files in a folder on the server called a *sync share*. You can specify a folder that already contains user data, which enables you to adopt Work Folders without migrating servers and data or immediately phasing out your existing solution.

## Common uses

 Administrators can use Work Folders to provide users with access to their work files while keeping centralized storage and control over the organization's data. Work Folders can also accomplish these specific applications:

- Provide a single point of access to work files from a user's work and personal computers and devices.

- Access work files while offline and then sync with the central file server when the PC or device next has internet or intranet connectivity.

- Deploy with existing deployments of Folder Redirection, Offline Files, and home folders.

- Use existing file server management technologies, such as file classification and folder quotas, to manage user data.

- Specify security policies to instruct user's PCs and devices to encrypt Work Folders and use a lock screen password.

- Use Failover Clustering with Work Folders to provide a high-availability solution.

## Features

Work Folders provides users with multiple ways to access, manage, and share work files. The following table describes the primary features of Work Folders:

| Features | Availability | Description |
| ------------------- | ------------------ | ----------------- |
| **Work Folders role service in Server Manager** | Windows Server 2019, Windows Server 2016, or Windows Server 2012 R2 | File and Storage Services provides a way to set up sync shares (folders that store user's work files), monitors Work Folders, and manages sync shares and user access. |
| **Work Folders cmdlets** | Windows Server 2019, Windows Server 2016, or Windows Server 2012 R2 | The [SyncShare](/powershell/module/syncshare/)  Windows PowerShell module contains comprehensive cmdlets for managing Work Folders servers. |
| **Work Folders integration with Windows** | Windows 10<p> Windows 8.1<p> Windows RT 8.1<p> Windows 7 (download required) | Work Folders provides the following functionality in Windows computers:<p> -   A Control Panel item that sets up and monitors Work Folders.<br />-   A File Explorer integration that enables easy access to files in Work Folders.<br />-   A sync engine that transfers files to and from a central file server while maximizing battery life and system performance. |
| **Work Folders app for devices** | Android<p> Apple iPhone and iPad® | An app that allows popular devices to access files in Work Folders. |

## Feature changes

The following table describes some of the major changes in Work Folders across different available versions and updates:

| Features | Availability | Status | Description |
| ---------------------------- | --------------------- | ----------------- | ----------------- |
| **Improved logging** | Windows Server 2019 | New to version | Event logs on the Work Folders server can be used to monitor sync activity and identify users that are failing sync sessions. Use Event ID 4020 in the Microsoft-Windows-SyncShare/Operational event log to identify which users are failing sync sessions. Use Event ID 7000 and Event ID 7001 in the Microsoft-Windows-SyncShare/Reporting event log to monitor users that are successfully completing upload and download sync sessions. |
| **Performance counters** | Windows Server 2019 | New to version | The following performance counters were added: Bytes downloaded/sec, Bytes uploaded/sec, Connected Users, Files downloaded/sec, Files uploaded/sec, Users with change detection, Incoming requests/sec and Outstanding requests. |
| **Improved server performance** | Windows Server 2019 | Updated | Performance improvements were made to handle more users per server. The limit per server varies and is based on the number of files and file churn. To determine the limit per server, users should be added to the server in phases. |
| **On-demand file access** | Windows 10 version 1803 | Added | This feature enables you to see and access all of your files. You control which files are stored on your PC and available offline. The rest of your files are always visible and don’t take up any space on your PC, but you need connectivity to the Work Folders file server to access them. |
| **Microsoft Entra application proxy support** | Windows 10 version 1703, Android, iOS | Added | Remote users can securely access their files on the Work Folders server using Microsoft Entra application proxy. |
| **Faster change replication** | Windows 10 and Windows Server 2016 | Updated | For Windows Server 2012 R2, when file changes are synced to the Work Folders server, clients aren't notified of the change and wait up to 10 minutes to get the update. When you use Windows Server 2016, the Work Folders server immediately notifies Windows 10 clients, and the file changes are synced immediately. This capability is new in Windows Server 2016 and requires a Windows 10 client. If you're using an older client or the Work Folders server is Windows Server 2012 R2, the client continues to poll every 10 minutes for changes. |
| **Integrated with Windows Information Protection (WIP)** | Windows 10 version 1607 | Added | If an administrator deploys WIP, Work Folders can enforce data protection by encrypting the data on the PC. The encryption uses a key associated with the Enterprise ID, which can be remotely wiped by using a supported mobile device management package such as Microsoft Intune. |

## Software requirements

Work Folders requires specific software depending on the operating system and version on which it's run. The following section lists the requirements and optional supporting services.

### Requirements for file servers and network infrastructure

- **Server requirement.** A server running Windows Server 2019, Windows Server 2016, or Windows Server 2012 R2 for hosting sync shares with user files.

- **Volume requirement.** A volume formatted with the NTFS file system for storing user files.

- **Password enforcement policy.** To enforce password policies on Windows 7 PCs, you must use Group Policy password policies. You also have to exclude the Windows 7 PCs from Work Folders password policies (if you use them).

- **A server certificate.** There must be a server certificate for each file server that will host Work Folders. These certificates should be from a certification authority (CA) that's trusted by your users&mdash;ideally a public CA.

- **(Optional) An Active Directory Domain Services forest.** Use this forest with the schema extensions in Windows Server 2012 R2 to support automatically referring PCs and devices to the correct file server when you use multiple file servers.

### Requirements for enabling users to sync across the internet

- **Server accessibility.** The ability to make a server accessible from the internet by creating publishing rules in your organization's reverse proxy or network gateway.

- **(Optional) Domain name.** A publicly registered domain name and the ability to create more public DNS records for the domain.

- **(Optional) Infrastructure.** Active Directory Federation Services (AD FS) infrastructure when you use AD FS authentication.

### Requirements for client computers

- PCs and devices must run one of the following operating systems:
  - Windows 10
  - Windows 8.1
  - Windows RT 8.1
  - Windows 7
  - Android 4.4 KitKat and later
  - iOS 10.2 and later

   > [!NOTE]
   > The Work Folders application for Android and iOS is no longer being actively developed and will remain on the respective app stores if the application is functioning properly.

- Windows 7 PCs must run one of the following editions of Windows:
  - Windows 7 Professional
  - Windows 7 Ultimate
  - Windows 7 Enterprise

- Windows 7 PCs must be joined to your organization's domain. They can't be joined to a workgroup.

- Enough free space on a local, NTFS-formatted drive to store all the user's files in Work Folders, plus 6 more GB of free space if Work Folders is located on the system drive, as it is by default. Work Folders uses the following location by default: **%USERPROFILE%\Work Folders**

     However, users can change the location during setup. microSD cards and USB drives formatted with the NTFS file system are supported locations. Sync stops if the drives are removed.

     The maximum size for individual files is 10 GB by default. There's no per-user storage limit. However, administrators can use the quotas functionality of File Server Resource Manager to implement quotas.

- Work Folders doesn't support rolling back the virtual machine state of client virtual machines. Instead perform backup and restore operations from inside the client virtual machine by using System Image Backup or another backup app.

## Other versions of Work Folders

If you want to download or use Work Folders on Windows 10, Windows 7, or an Android or iOS device, see:

- [Work Folders for Windows 10](https://support.microsoft.com/help/12370/windows-10-work-folders)
- [Work Folders for Windows 7 (64-bit download)](https://www.microsoft.com/download/details.aspx?id=42558)
- [Work Folders for Windows 7 (32-bit download)](https://www.microsoft.com/download/details.aspx?id=42559)
- [Work Folders for iOS](https://itunes.apple.com/app/work-folders/id950878067)

> [!NOTE]
> The Work Folders application for Android and iOS is no longer being actively developed. The Work Folders application for Android is no longer available in the Google Play store. The Work Folders application for iOS will remain in the Apple App Store if the application is functioning properly.

## Comparison with other sync technologies

The following table discusses how various Microsoft sync technologies are positioned and when to use each.

| | Work Folders | Offline Files | OneDrive for Business | OneDrive |
| - | ------------------ | ------------------- | -------------------------- | -------------- |
| **Technology summary** | Syncs files that are stored on a file server with PCs and devices | Syncs files that are stored on a file server with PCs that have access to the corporate network (can be replaced by Work Folders) | Syncs files that are stored in Microsoft 365 or in SharePoint with PCs and devices inside or outside a corporate network, and provides document collaboration functionality | Syncs personal files that are stored in OneDrive with PCs, Mac computers, and devices |
| **Intended to provide user access to work files** | Yes | Yes | Yes | No |
| **Cloud service** | None | None | Microsoft 365 | Microsoft OneDrive |
| **Internal network servers** | File servers running Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019 | File servers | SharePoint server (optional) | None |
| **Supported clients** | PCs, iOS | PCs in a corporate network or connected through DirectAccess, VPNs, or other remote access technologies | PCs, iOS, Android, Windows Phone | PCs, Mac computers, Windows Phone, iOS, Android |

> [!NOTE]
> In addition to the sync technologies listed in the previous table, Microsoft offers other replication technologies, including DFS Replication, which is designed for server-to-server replication, and BranchCache, which is designed as a branch office WAN acceleration technology. For more information, see the [DFS Namespaces overview](/windows-server/storage/dfs-namespaces/dfs-overview), [DFS Replication overview](/windows-server/storage/dfs-replication/dfsr-overview), and [BranchCache Overview](/windows-server/networking/branchcache/branchcache).

## Server Manager

Work Folders is part of the File and Storage Services role. You can install Work Folders by using the Add Roles and Features Wizard or the `Install-WindowsFeature` cmdlet. Both methods accomplish the following tasks:

- Add the **Work Folders** page to **File and Storage Services** in Server Manager.

- Install the Windows Sync Shares service, which is used by Windows Server to host sync shares.

- Install the SyncShare Windows PowerShell module to manage Work Folders on the server.

## Interoperability with Azure virtual machines

 You can run this Windows Server role service on a virtual machine in Azure. This scenario has been tested with Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019.

To learn how to get started, see [Virtual machines in Azure](/azure/virtual-machines).

## Related links

| Content type | References |
| ------------------ | ---------------- |
| **Product evaluation** | -   [Work Folders for Android – Released](https://techcommunity.microsoft.com/t5/storage-at-microsoft/work-folders-for-android-released/ba-p/425656) (blog post)<br />-   [Work Folders for iOS – iPad App Release](https://techcommunity.microsoft.com/t5/storage-at-microsoft/work-folders-for-ios-8211-ipad-app-release/ba-p/425499) (blog post)<br />-   [Introducing Work Folders on Windows Server 2012 R2](https://techcommunity.microsoft.com/t5/storage-at-microsoft/introducing-work-folders-on-windows-server-2012-r2/ba-p/424741) (blog post)<br />-   [Work Folders Test Lab Deployment](https://techcommunity.microsoft.com/t5/storage-at-microsoft/work-folders-test-lab-deployment/ba-p/424767) (blog post)<br />-   [Work Folders for Windows 7](https://techcommunity.microsoft.com/t5/storage-at-microsoft/work-folders-for-windows-7/ba-p/425338) (blog post) |
| **Deployment** | -   [Planning a Work Folders deployment](plan-work-folders.md)<br />-   [Deploying Work Folders](deploy-work-folders.md)<br />-   [Deploy Work Folders with AD FS and Web Application Proxy: Overview](deploy-work-folders-adfs-overview.md)<br />-   [Deploying Work Folders with Microsoft Entra Application Proxy](https://techcommunity.microsoft.com/t5/storage-at-microsoft/enable-remote-access-to-work-folders-using-azure-active/ba-p/425998)<br />- [Offline Files (CSC) to Work Folders Migration Guide](https://techcommunity.microsoft.com/t5/storage-at-microsoft/offline-files-csc-to-work-folders-migration-guide/ba-p/425800)<br />-   [Performance Considerations for Work Folders Deployments](https://techcommunity.microsoft.com/t5/storage-at-microsoft/performance-considerations-for-work-folders-deployments/ba-p/425037)<br />-   [Work Folders for Windows 7 (64-bit download)](https://www.microsoft.com/download/details.aspx?id=42558)<br />-   [Work Folders for Windows 7 (32-bit download)](https://www.microsoft.com/download/details.aspx?id=42559) |
| **Operations** | -   [Work Folders iPad app: FAQ](https://windows.microsoft.com/windows/work-folders-ipad-faq) (for users)<br />-   [Work Folders Certificate Management](https://techcommunity.microsoft.com/t5/storage-at-microsoft/work-folders-certificate-management/ba-p/424809) (blog post)<br />-   [Monitoring Windows Server 2012 R2 Work Folders Deployments](https://techcommunity.microsoft.com/t5/storage-at-microsoft/monitoring-windows-server-2012-r2-work-folders-deployments/ba-p/425019) (blog post)<br />-   [SyncShare (Work Folders) Cmdlets in Windows PowerShell](/powershell/module/syncshare/)<br />-   [Storage and File Services PowerShell Cmdlets Quick Reference Card For Windows Server 2012 R2 Preview Edition](https://techcommunity.microsoft.com/t5/storage-at-microsoft/storage-and-file-services-powershell-cmdlets-quick-reference/ba-p/424772) |
| **Troubleshooting** | -   [Windows Server 2012 R2 – Resolving Port Conflict with IIS Websites and Work Folders](https://techcommunity.microsoft.com/t5/storage-at-microsoft/windows-server-2012-r2-8211-resolving-port-conflict-with-iis/ba-p/424985) (blog post)<br />-   [Common Errors in Work Folders](https://techcommunity.microsoft.com/t5/storage-at-microsoft/troubleshooting-work-folders-on-windows-client/ba-p/425627) |
| **Community resources** | -   [File Services and Storage Forum](/answers/topics/windows-server-storage.html)<br />-   [Storage at Microsoft Blogs](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB)<br />-   [Ask the Directory Services Team Blog](/archive/blogs/askds/) |
| **Related technologies** | -   [Storage in Windows Server 2019 and Windows Server 2016](../storage.yml)<br>-   [File and Storage Services](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831487(v=ws.11))<br />-   [File Server Resource Manager](/windows-server/storage/fsrm/fsrm-overview)<br />-   [Folder Redirection, Offline Files, and Roaming User Profiles](/windows-server/storage/folder-redirection/folder-redirection-rup-overview)<br />-   [BranchCache Overview](/windows-server/networking/branchcache/branchcache)<br />-   [DFS Namespaces overview](/windows-server/storage/dfs-namespaces/dfs-overview)<br />-  [DFS Replication overview](/windows-server/storage/dfs-replication/dfsr-overview) |
