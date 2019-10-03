---
title: Install Server Backup on your MultiPoint server
description: Walks you through the steps to install the backup and recovery tools
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e4331370-ba07-4529-92ab-db14a41bfc3b
author: evaseydl
manager: scottman
ms.author: evas
---
# Install Server Backup on your MultiPoint server
It is recommended that you consider a backup and recovery plan for your MultiPoint servers.
  
A good backup and recovery plan is important for any size environment. Windows Server Backup is a feature in Windows Server 2016 that provides a set of wizards and other tools for you to perform basic backup and recovery tasks for the server on which it is installed. You can use Windows Server Backup to back up a full server (all volumes), selected volumes, the system state, or specific files or folders, and to create a backup that you can use to rebuild your system.  
  
You can recover volumes, folders, files, certain applications, and the system state. And, for disasters like hard disk failures, you can rebuild a system either from scratch or by using alternate hardware. To do this, you must have a backup of the full server or just the volumes that contain operating system files and the Windows Recovery Environment. This restores your complete system onto your old system or onto a new hard disk.  
  
A key feature of Windows Server Backup is the ability to schedule backups to run automatically.  
  
Use the following procedures to set up the type of backup you require.  
  
## Install backup and recovery tools  
  
1.  From the **Start** screen, open **Server Manager**.  
  
2.  Click **Add Roles and Features** to start the Add Roles Wizard. Then click **Next** after you review the **Before you begin** notes.  
  
3.  Select the **Role based or feature based installation** option, and then click **Next**.  
  
4.  Select the local computer that you are managing, and click **Next**.  
  
    The Add Features Wizard opens.  
  
5.  On the **Select Features** page, expand Windows Server Backup Features, select the check boxes for **Windows Server Backup** and **Command-line Tools**, and then click **Next**.  
  
    > [!NOTE]  
    > Or, if you just want to install the snap-in and the Wbadmin command-line tool, expand **Windows Server Backup Features**, and then select the **Windows Server Backup** check box only—make sure the **Command-line Tools** check box is clear.  
  
6.  On the **Confirm Installation Selections** page, review your choices, and then click **Install**.  
  
    If any errors occur during the installation, the **Installation Results** page will note the errors.  
  
7.  After the installation completes successfully, you should be able to access these backup and recovery tools:  
  
    -   To open the Windows Server Backup snap-in, on the **Start** screen, type **backup**, and then click **Windows Server Backup** in the results.  
  
    -   To start the Wbadmin tool and view syntax for its commands: On the **Start** screen, type **command**. In the results, right-click **Command Prompt**, click **Run as administrator** at the bottom of the page, and then click **Yes** at the confirmation prompt. At the command prompt, type **wbadmin /?** and press ENTER. You should see command syntax and descriptions for the tool.  
  
## Configure backups using Windows Server Backup  
  
-   Follow the guidance in [Backing Up Your Server](https://technet.microsoft.com/library/cc753528.aspx). 