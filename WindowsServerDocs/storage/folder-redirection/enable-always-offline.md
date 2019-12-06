---
title: Enable Always Offline mode for faster access to files
description: How to use the Always Offline mode of Offline Files to provide faster access to cached files and redirected folders.
ms.prod: windows-server 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage 
ms.date: 09/10/2018
ms.localizationpriority: medium
---
# Enable Always Offline mode for faster access to files

>Applies to: Windows 10, Windows 8, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012, Windows Server 2012 R2, and Windows (Semi-annual Channel)

This document describes how to use the Always Offline mode of Offline Files to provide faster access to cached files and redirected folders. Always Offline also provides lower bandwidth usage because users are always working offline, even when they are connected through a high-speed network connection.

## Prerequisites

To enable Always Offline mode, your environment must meet the following prerequisites.

- An Active Directory Domain Services (AD DS) domain with client computers joined to the domain. There are no forest or domain functional-level requirements or schema requirements.
- Client computers running Windows 10, Windows 8.1, Windows 8, Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012. (Client computers running earlier versions of Windows might continue to transition to Online mode on very high-speed network connections.)
- A computer with Group Policy Management installed.

## Enable Always Offline mode

To enable Always Offline mode, use Group Policy to enable the **Configure slow-link mode** policy setting and set the latency to **1** (millisecond). Doing so causes client computers running Windows 8 or Windows Server 2012 to automatically use Always Offline mode.

>[!NOTE]
>Computers running Windows 7, Windows Vista, Windows Server 2008 R2, or Windows Server 2008 might continue to transition to the Online mode if the latency of the network connection drops below one millisecond.

1. Open **Group Policy Management**.
2. To optionally create a new Group Policy Object (GPO) for Offline Files settings, right-click the appropriate domain or organizational unit (OU), and then select **Create a GPO in this domain, and link it here**.
3. In the console tree, right-click the GPO for which you want to configure the Offline Files settings and then select **Edit**. The **Group Policy Management Editor** appears.
4. In the console tree, under **Computer Configuration**, expand **Policies**, expand **Administrative Templates**, expand **Network**, and expand **Offline Files**.
5. Right-click **Configure slow-link mode**, and then select **Edit**. The **Configure slow-link mode** window will appear.
6. Select **Enabled**.
7. In the **Options** box, select **Show**. The **Show Contents window** will appear.
8. In the **Value name** box, specify the file share for which you want to enable Always Offline mode.
9. To enable Always Offline mode on all file shares, enter **\***.
10. In the **Value** box, enter **Latency=1** to set the latency threshold to one millisecond, and then select **OK**.

>[!NOTE]
>By default, when in Always Offline mode, Windows synchronizes files in the Offline Files cache in the background every two hours. To change this value, use the **Configure Background Sync** policy setting.

## More information

* [Folder Redirection, Offline Files, and Roaming User Profiles overview](folder-redirection-rup-overview.md)
* [Deploy Folder Redirection with Offline Files](deploy-folder-redirection.md)