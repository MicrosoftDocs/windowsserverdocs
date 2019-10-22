---
title: Connect to a Remote Computer
description: This article describes how to connect to a remote computer to manage storage resources from File Server Resource Manager
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Connect to a Remote Computer 

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

To manage storage resources on a remote computer, you can connect to the computer from File Server Resource Manager. While you are connected, File Server Resource Manager allows you to manage quotas, screen files, manage classifications, schedule file management tasks, and generate reports with those remote resources.

> [!Note]
> File Server Resource Manager can manage resources on either the local computer or a remote computer, but not both at the same time.

## To connect to a remote computer from File Server Resource Manager

1.  In **Administrative Tools**, click **File Server Resource Manager**.

2.  In the console tree, right-click **File Server Resource Manager**, and then click **Connect to Another Computer**.

3.  In the **Connect to Another Computer** dialog box, click **Another computer**. Then type the name of the server you want to connect to (or click **Browse** to search for a remote computer).

4.  Click **OK**.

> [!Important]
> The **Connect to Another Computer** command is available only when you open File Server Resource Manager from **Administrative Tools**. When you access File Server Resource Manager from Server Manager, the command is not available.

## Additional considerations

To manage remote resources with File Server Resource Manager:

-   You must be logged on to the local computer with a domain account that is a member of the **Administrators** group on the remote computer.
-   The remote computer must be running Windows Server, and File Server Resource Manager must be installed.
-   The **Remote File Server Resource Manager Management** exception on the remote computer must be enabled. Enable this exception by using Windows Firewall in Control Panel.

## See also

-   [Managing Remote Storage Resources](managing-remote-storage-resources.md)