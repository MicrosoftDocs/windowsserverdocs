---
title: "Customize Server Backup"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 19b2559c-6090-45af-9a08-2eefc28473c8
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Customize Server Backup

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

## Turn off Server Backup by Default  
 You can choose to turn off Server Backup by default. You need to set the value of **HKEY_LOCAL_MACHINE\Software\Microsoft\Windows Server\ServerBackup\ProviderDisabled** to 1 in order to enable this option.  
  
 When this key is set, the Server Backup User interface will not be exposed through Dashboard or Launchpad. This allows you to utilize third-party applications for Server Backup.  
  
#### To add ServerBackup\ProviderDisabled? registry key and set the value to 1  
  
1.  On the server, click **Start**, click **Run**, type **regedit** in the **Open** textbox, and then click **OK**.  
  
2.  In the navigation pane, expand **HKEY_LOCAL_MACHINE**, expand **SOFTWARE**, expand **Microsoft**, expand **Windows Server**, and then expand **ServerBackup**.  
  
3.  Right-click **ServerBackup**, click **New**, and then click **DWARD Value**.  
  
4.  For name, enter **ProviderDisabled**.  
  
5.  Right-click the name, select **Modify**, enter **1** for the value data, and then click **OK**.  
  
## Turn on Server Backup  
 You can turn on Server Backup if it was turned off by creating **ProviderDisabled** registry key (as described earlier in this document).  
  
 You need to delete the key **HKEY_LOCAL_MACHINE\Software\Microsoft\Windows Server\ServerBackup\ProviderDisabled** in order to enable default server backup, change the service start type of Windows Server Server Backup Service and restart the server.  
  
#### To delete ServerBackup\ProviderDisabled? registry key  
  
1.  On the server, move your mouse to the upper right corner of the screen, and click **Search**.  
  
2.  In the Search box, type **regedit**, and then click the **Regedit** application.  
  
3.  In the navigation pane, expand **HKEY_LOCAL_MACHINE**, expand **SOFTWARE**, expand **Microsoft**, expand **Windows Server**, and then expand **ServerBackup**.  
  
4.  Right-click **ProviderDisabled**, and then click **Delete**.  
  
#### Change the start type of Windows Server Server Backup Service  
  
1.  On the server, move your mouse to the upper right corner of the screen, and click **Search**.  
  
2.  In the Search box, type **services.msc**, and then click **Services** application.  
  
3.  In the services pane, right-click the **Windows Server Server Backup Service**, and click **Properties**.  
  
4.  In **General** tab, select **Automatic** for **Startup type**.  
  
5.  Click **OK** to close the dialog.  
  
#### Restart the server  
  
1.  On the server, move your mouse to the upper right corner of the screen, click **Settings**, click **Power**, and then click Restart.