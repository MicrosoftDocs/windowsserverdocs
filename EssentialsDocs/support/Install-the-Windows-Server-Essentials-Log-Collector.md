---
title: "Install the Windows Server Essentials Log Collector"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d271c54f-1ffa-464e-afa5-27b8df61854e
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Install the Windows Server Essentials Log Collector

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

The  Windows Server Essentials Log Collector installation wizard installs the Log Collector as a Launchpad Add-in. You can install and use the Log Collector on network computers or the server, or both. After installation, the Log Collector will appear on the Dashboard.  
  
###  <a name="BKMK_ToInstall"></a> To install the Log Collector  
  
1.  Download the Log Collector installation package to any server or computer on the network.  
  
    > [!NOTE]
    >  You can [download the Log Collector installation package](https://go.microsoft.com/fwlink/p/?LinkId=255470) from the Microsoft.  
  
2.  Double-click the Log Collector icon.  
  
3.  If you are running the installation from a network computer, enter your server administrator credentials when prompted.  
  
4.  Choose to accept the Microsoft Software License Terms.  
  
5.  To install the Log Collector only on the server, select the **Only on the server** check box. To install the Log Collector on all network computers, select the **On the server and on all of the computers on the network** check box.  
  
6.  Click **Install the Add-in**.  
  
###  <a name="BKMK_Reinstall"></a> Reinstalling the Log Collector  
 If it is necessary to reinstall the Log Collector, you must uninstall and reinstall the Log Collector on the server and the network computers on the network. By uninstalling the Log Collector on the server from the Dashboard, all network computers will automatically uninstall the Log Collector.  
  
##### To uninstall and reinstall the Log Collector  
  
1.  Open the Dashboard.  
  
2.  Click the **Add-in** tab, select **Log Collector** from the list, and then click **Uninstall**.  
  

3.  Download and install the Log Collector by performing the steps in the previous procedure, [To install the Log Collector](Install-the-Windows-Server-Essentials-Log-Collector.md#BKMK_ToInstall).  

3.  Download and install the Log Collector by performing the steps in the previous procedure, [To install the Log Collector](../support/Install-the-Windows-Server-Essentials-Log-Collector.md#BKMK_ToInstall).  

  
### Manually install the Log Collector  
 If the installation wizard failed to install the Log Collector, you can install the Log Collector on a single computer using the following procedure.  
  
##### To manually install the Log Collector  
  
1.  Rename the extension of the downloaded installation file from .wssx to .cab.  
  
2.  Double-click the installation file name.  
  
3.  Click **OK** if you are prompted.  
  
4.  Double-click the file name ending with '.msi' and select a folder in which to extract it.  
  
5.  Navigate to the folder with the extracted file and double-click the installation file to use the wizard to finish the installation.
