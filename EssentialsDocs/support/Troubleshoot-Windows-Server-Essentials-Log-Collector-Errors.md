---
title: "Troubleshoot Windows Server Essentials Log Collector Errors"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fa2e1685-31c0-4d4f-a10a-6c8885dfc493
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Troubleshoot Windows Server Essentials Log Collector Errors

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

When you run the Log Collector, you may encounter one of the following errors. To resolve an issue, follow the guidance provided for the associated error.  
  
> [!NOTE]
> In this document, the computers on your network, other than your server, are called network computers.
  
###  <a name="BKMK_TheDestinationFolderIsNotValid"></a> The destination folder is not valid  
 **Cause:** The folder where you are attempting to copy the log files may not exist or may not have enough space to hold the files.  
  
 **Solution:** Check that the selected folder exists and that there is enough free space available on the drive for the files. You should also ensure that there is enough free space remaining in the temp folder on the drive.  
  
###  <a name="BKMK_ANetworkErrorHasOccurred"></a> A network error has occurred  
 **Cause:** There may be a network-related problem on the network computer or server.  
  
 **Solution:** Ensure that all computers and networked devices are powered on, and that they are connected to the network. If you are unable to resolve the issue, contact the person who maintains your network for assistance.  
  
###  <a name="BKMK_CannotCollectLogFiles"></a> Cannot collect log files for the computer  
 **Cause:** The Log Collector may not be installed on the computer because the computer did not successfully connect to the server using Connect Computer to the Server wizard.  
  
 **Solution:** For information about how to resolve issues regarding connections to your server, see [Troubleshoot connecting computers to the server](https://go.microsoft.com/fwlink/p/?LinkID=241492).  
  
 If you are still unable to connect the computer to the server, then you can copy the log files manually to a USB flash drive as follows:  
  
-   For client computers that are running Windows 7, Windows 8, or Windows Multipoint Server, you can copy the **Logs** folder located at **%sysdir%\programdata\Microsoft\Windows Server**.  
  
###  <a name="BKMK_YouDoNotHavePermission"></a> You do not have permission to save the log files to the selected folder  
 **Cause:** You may not have write permission to the folder you selected for saving the log files.  
  
 **Solution:** If you are using the default path to save log files, ensure that you have write permission for the shared folder **\\\\<ServerName\>\Logs**. If you are storing logs on a network computer, ensure that you have write permission for the folder you selected for saving the log files.  
  
###  <a name="BKMK_TheComputerIsNotConfiguredProperly"></a> The computer is not configured properly to collect the log files  
 **Cause:** The computer has not been configured properly for the Log Collector.  
  
 **Solution:** Re-install the Log Collector. See [Reinstalling the Log Collector](Install-the-Windows-Server-Essentials-Log-Collector.md#BKMK_Reinstall).  
  
###  <a name="BKMK_AnUnknownErrorOccurred"></a> An unknown error occurred  
 **Cause:** Unknown.  
  
 **Solution 1:** Re-run the Log Collector. If the error occurs again, ensure there are no connectivity issues. You can also try reinstalling the Log Collector. See [Reinstalling the Log Collector](Install-the-Windows-Server-Essentials-Log-Collector.md#BKMK_Reinstall). If you are unable to resolve the issue, contact the person who maintains your network for assistance.  
  
 **Solution 2:** First, try to open the folder where the log files are saved. If the zip file with computer name is already generated, ignore this error and use the log files instead. If there are no log files generated, re-run the Log Collector. If the error occurs again, ensure there are no connectivity issues. You can also try reinstalling the Log Collector. See [Reinstalling the Log Collector](Install-the-Windows-Server-Essentials-Log-Collector.md#BKMK_Reinstall). If you are unable to resolve the issue, contact the person who maintains your network for assistance.