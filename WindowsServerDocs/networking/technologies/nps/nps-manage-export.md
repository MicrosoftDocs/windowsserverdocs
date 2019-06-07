---
title: Export an NPS Configuration for Import on Another Server
description: You can use this topic to learn how to export a Network Policy Server configuration in Windows Server 2016.
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: d268dc57-78f8-47ba-9a7a-a607e8b9225c
ms.author: pashort 
author: shortpatti
---

# Export an NPS Configuration for Import on Another Server

Applies To: Windows Server 2016

You can export the entire NPS configuration — including RADIUS clients and servers, network policy, connection request policy, registry, and logging configuration — from one NPS for import on another NPS. 

Use one of the following tools to export the NPS configuration:

- In Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012, you can use Netsh, or you can use Windows PowerShell.
- In Windows Server 2008 R2 and Windows Server 2008, use Netsh.

> [!IMPORTANT]
> Do not use this procedure if the source NPS database has a higher version number than the version number of the destination NPS database. You can view the version number of the NPS database from the display of the **netsh nps show config** command.

Because NPS configurations are not encrypted in the exported XML file, sending it over a network might pose a security risk, so take precautions when moving the XML file from the source server to the destination servers. For example, add the file to an encrypted, password protected archive file before moving the file. In addition, store the file in a secure location to prevent malicious users from accessing it.

> [!NOTE]
> If SQL Server logging is configured on the source NPS, SQL Server logging settings are not exported to the XML file. After you import the file on another NPS, you must manually configure SQL Server logging.

## Export and Import the NPS configuration by using Windows PowerShell

For Windows Server 2012 and later operating system versions, you can export the NPS configuration using Windows PowerShell.

The command syntax for exporting the NPS configuration is as follows. 

    Export-NpsConfiguration -Path <filename>

The following table lists parameters for the **Export-NpsConfiguration** cmdlet in Windows PowerShell. Parameters in bold are required.

|Parameter|Description|
|---------|-----------|
|Path|Specifies the name and location of the XML file to which you want to export the NPS configuration.|

**Administrative credentials**

To complete this procedure, you must be a member of the Administrators group.

### Export Example 

In the following example, the NPS configuration is exported to an XML file located on the local drive. To run this command, run Windows PowerShell as Administrator on the source NPS, type the following command, and press Enter.

`Export-NpsConfiguration –Path c:\config.xml` 

For more information, see [Export-NpsConfiguration](https://technet.microsoft.com/library/jj872749.aspx).

After you have exported the NPS configuration, copy the XML file to the destination server.

The command syntax for importing the NPS configuration on the destination server is as follows.

    Import-NpsConfiguration [-Path] <String> [ <CommonParameters>]

### Import Example

The following command imports settings from the file named C:\Npsconfig.xml to NPS. To run this command, run Windows PowerShell as Administrator on the destination NPS, type the following command, and press Enter.

    PS C:\> Import-NpsConfiguration -Path "C:\Npsconfig.xml"

For more information, see [Import-NpsConfiguration](https://technet.microsoft.com/library/jj872750.aspx).

## Export and Import the NPS configuration by using Netsh

You can use Network Shell \(Netsh\) to export the NPS configuration by using the **netsh nps export** command.

When the **netsh nps import** command is run, NPS is automatically refreshed with the updated configuration settings. You do not need to stop NPS on the destination computer to run the **netsh nps import** command, however if the NPS console or NPS MMC snap-in is open during the configuration import, changes to the server configuration are not visible until you refresh the view. 

> [!NOTE]
> When you use the **netsh nps export** command, you are required to provide the command parameter **exportPSK** with the value **YES**. This parameter and value explicitly state that you understand that you are exporting the NPS configuration, and that the exported XML file contains unencrypted shared secrets for RADIUS clients and members of remote RADIUS server groups.

**Administrative credentials**

To complete this procedure, you must be a member of the Administrators group.

### To copy an NPS configuration to another NPS using Netsh commands

1. On the source NPS, open **Command Prompt**, type **netsh**, and then press Enter.

2. At the **netsh** prompt, type **nps**, and then press Enter. 

3. At the **netsh nps** prompt, type **export filename=**"*path\file.xml*" **exportPSK=YES**, where *path* is the folder location where you want to save the NPS configuration file, and *file* is the name of the XML file that you want to save. Press Enter. 

This stores configuration settings \(including registry settings\) in an XML file. The path can be relative or absolute, or it can be a Universal Naming Convention \(UNC\) path. After you press Enter, a message appears indicating whether the export to file was successful.

4. Copy the file you created to the destination NPS.

5. At a command prompt on the destination NPS, type **netsh nps import filename=**"*path\file.xml*", and then press Enter. A message appears indicating whether the import from the XML file was successful.

For more information about netsh, see [Network Shell (Netsh)](../netsh/netsh.md).

