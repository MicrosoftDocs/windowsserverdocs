---
title: "Overview of the Launchpad in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 198d16cb-3d07-4706-be89-ad14a5f7dc47
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Overview of the Launchpad in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

The Windows Server Essentials Launchpad is a small application that is installed on a computer the first time the computer connects to the server. The Launchpad provides authenticated users with access to key features of Windows Server Essentials including computer backups, shared files and media, and the Remote Web Access site. Users can access these features from either domain-joined computers or non-domain joined computers. The Launchpad also provides real-time information and notifications about the health of the computer. Administrators can use the Launchpad to access the server Dashboard, even if the computer is not connected to the network.  
  
 OEMs and Independent Software Vendors (ISVs) who develop add-ins for Windows Server Essentials can use the Launchpad to extend add-in functionality to computers on the network.  
  
 The following Windows operating systems support the use of the Windows Server Essentials Launchpad:  
  
- **Windows 8**: All editions.  
  
- **Windows 7**: All editions.  
- **Windows 10**: All editions. 
  
  The following operating systems do not support the use of the Windows Server Essentials Launchpad:  
  
- **Additional servers**: You cannot run the Windows Server Essentials Launchpad on any additional computers that run a Windows Server operating system.  
  
  In this topic:  
  
- [Use the Launchpad](Overview-of-the-Launchpad-in-Windows-Server-Essentials.md#BKMK_Launchpad)  
  
- [Use the Launchpad with a Mac computer](Overview-of-the-Launchpad-in-Windows-Server-Essentials.md#BKMK_Mac)  
  
##  <a name="BKMK_Launchpad"></a> Use the Launchpad  
 The following links and information are available on the Windows Server Essentials Launchpad.  
  
### Backup  
 Click **Backup** to open the **Backup Properties** for the computer. On the **Backup Properties** page, you can:  
  
- Start or stop a backup.  
  
- View the status and details for the most recent backup.  
  
- Specify how to manage computer power when backup runs.  
  
  For information about how to use Launchpad to back up your computer, see [Manage Client Backup](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md).  
  
### Remote Web Access  
 Click **Remote Web Access** to open the web browser to the Remote Web Access site. The Remote Web Access site enables you to connect to other computers and to access some of the network resources from within the office or from any remote location with an Internet-enabled computer. For more information about Remote Web Access, see [Manage Remote Web Access](Manage-Remote-Web-Access-in-Windows-Server-Essentials.md).  
  
### Shared Folders  
 Click **Shared Folders** to open Windows Explorer to the location of the shared folders on the server. For information about sharing files and folders, see the topic [Manage Server Folders](Manage-Server-Folders-in-Windows-Server-Essentials.md).  
  
### Dashboard  
 Click  **Dashboard** to open the **Sign in** page for access to the Windows Server Essentials Dashboard. After you sign in, a Remote Desktop connection to the server Dashboard opens. For more information about the Dashboard, see [Dashboard Overview](Overview-of-the-Dashboard-in-Windows-Server-Essentials.md).  
  
> [!NOTE]
>  To use this feature, you must have the proper access or permissions to log on to the server.  
  
### Microsoft Office 365  
 The **Microsoft Office 365** link only appears on the Launchpad if the user has an Office 365 account. Click  **Microsoft Office 365** to access additional links to the Office 365 resources. For more information, see [Quick Start Guide to Using Microsoft Office 365](../use/Quick-Start-Guide-to-Using-Microsoft-Office-365-with-Windows-Server-Essentials.md).  
  
### Computer health alerts  
 Alerts that appear on the Launchpad provide a quick status as to the immediate health of the computer. To view information about a health alert, click an alert indicator to open the alert viewer. Health alerts appear in the viewer based on level of severity. The most severe alerts appear first in the list; less severe alerts appear later in the list. For more information about computer health alerts, see [Manage System Health](Manage-System-Health-in-Windows-Server-Essentials.md).  
  
##  <a name="BKMK_Mac"></a> Use the Launchpad with a Mac computer  
 You can connect a Mac® computer running Mac OS X® 10.5 or later to  Windows Server Essentials,  Windows Server Essentials, or  Windows Server 2012 R2 or by downloading and installing the connector software. When you finish installing the connector software, you can choose to automatically start the Launchpad at startup.  
  
 The Launchpad is a small application that provides authenticated users with access to key features of the server, including shared files and media, add-ins, and Remote Web Access. The Launchpad also provides real-time information and notifications about the health of the computer.  
  
> [!NOTE]
>  Server administrators cannot use the Launchpad or Remote Web Access on a Mac computer to open the server Dashboard and manage the server.  
  
### Backup  
 Click **Backup** to set up Time Machine to back up your computer and to change Time Machine settings. For more information about Time Machine, see the documentation from the manufacturer of your computer.  
  
### Remote Web Access  
 Click **Remote Web Access** to open the web browser to the  Remote Web Access site. The  Remote Web Access enables you to access the shared files and folders on the server from any remote location with an Internet-enabled computer. You can upload files, play music and videos on the web-based Media Play, and view pictures and play slide shows. For more information, see [Use Remote Web Access](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md).  
  
### Shared Folders  
 Click **Shared Folders** to open Finder to the location of the shared folders on the server. For information about sharing files and folders, see [Use Shared Folders](../use/Use-Shared-Folders-in-Windows-Server-Essentials.md).  
  
### Computer health alerts  
 Alerts that appear on the Launchpad provide a quick status about the immediate health of the computer. To view information about a health alert, click an alert indicator to open the alert viewer. Health alerts appear in the viewer based on level of severity. The most severe alerts appear first in the list. Less severe alerts appear later in the list.  
  
## See also  
  
-   [Get Connected](../use/Get-Connected-in-Windows-Server-Essentials.md)  
  
-   [Use Windows Server Essentials](../use/Use-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)
