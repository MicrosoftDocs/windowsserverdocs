---
title: Installing Windows Server Backup_deleted
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 37bc8760-2495-4389-8d38-4571fdf9ef8e
author: femila
---
# Installing Windows Server Backup_deleted
Windows Server Backup is not installed by default. You can use the Add Features Wizard in Server Manager to install it. After you use install Windows Server Backup, you can click **Windows Server Backup** on the **Administrative Tools** menu to manage backup operations, and you can use Wbadmin.exe to run backup commands from the command line.  
  
You must also install the Windows PowerShell feature on the same computer to run Windows Server Backup command\-line tools. If the Windows PowerShell feature is not installed when you select **Command\-line Tools** during Windows Server Backup installation, you are prompted to install it.  
  
### To install Windows Server Backup by using Server Manager  
  
1.  Click **Start**, and then click **Server Manager**.  
  
2.  [!INCLUDE[uac_appears](../Token/uac_appears_md.md)]  
  
3.  In **Features Summary**, click **Add Features**.  
  
4.  In the list of features, double\-click **Windows Server Backup Features**, click **Windows Server Backup**, click **Command\-line tools**, and then click **Next**.  
  
5.  If Windows PowerShell is not installed, click **Add Required Features**, and then click **Next**.  
  
6.  On the **Confirmation Installation Selections** page, click **Install**.  
  
7.  Click **Close**.  
  
You can also use Optional Component Setup \(OCSetup\) to install Windows Server Backup features from the command line.  
  
### To install Windows Server Backup by using the command line  
  
-   At a command prompt, type the following command, and then press ENTER:  
  
    `ocsetup WindowsServerBackup`  
  
