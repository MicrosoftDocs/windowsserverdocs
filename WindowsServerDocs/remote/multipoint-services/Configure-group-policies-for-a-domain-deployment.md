---
title: Configure group policies for a domain deployment
description: Learn how to set up group policies in MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 13e5fa90-d330-4155-a6b8-78eb650cbbfa
author: evaseydl    
manager: scottman
ms.author: evas
---
# Configure group policies for a domain deployment
To ensure that your domain deployment of MultiPoint Services works properly, apply the following group policy settings to the WMSshell user account on a MultiPoint Services system.  
  
> [!IMPORTANT]  
> Some group policy settings can prevent required configuration settings from being applied to MultiPoint Services. Be sure that you understand and define your group policy settings so that they work correctly on MultiPoint Services. For example, a Group Policy setting that prevents Autologon could present problems with MultiPoint Services logon behavior.  
  
## Update group policies for the WMSshell user account 
The WMSshell user account is a system account which MultiPoint services uses to sign-in into the console, where the actual stations are created. This account is not meant to be managed by MultiPoint Manager.
  
> [!NOTE]  
> To find out how to update group policies, see [Local Group Policy Editor](https://technet.microsoft.com/library/dn265982.aspx).  
  
**POLICY:** User Configuration > Administrative templates > Control Panel > **Personalization**  
  
Assign the following values:  
  
|Setting|Values|  
|-----------|----------|  
|Enable screen saver|Disabled|  
|Screen saver timeout|Disabled<br /><br />Seconds: xxx|  
|Password protect the screen saver|Disabled|  
  
**POLICY:** Computer Configuration >Windows Settings >Security Settings >Local Policies >User Rights Assignment > **Allow log on locally**  
  
|Setting|Values|  
|-----------|----------|  
|Allow log on locally|Ensure that the list of accounts includes the WMSshell account.<br /><br />**Note:** By default, the WMSshell account is a member of the Users group. If the Users group is in the list, and WMSshell is a member of the Users group, you do not need to add the WMSshell account to the list.|  
  
> [!IMPORTANT]  
> When you set any group policies, make sure that the policies do not interfere with automatic updates and error Windows error reporting on the MultiPoint server. These are set by the **Install updates automatically** and **Automatic Windows Error Reporting** settings that were selected during Windows MultiPoint Server installation, configured in MultiPoint Manager using **Edit server settings**, or configured in scheduled updates for Disk Protection.  
  
## Update the Registry  
For a domain deployment of MultiPoint Services, you should update the following registry subkeys.  
  
> [!IMPORTANT]  
> Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.  
  
#### To update Registry subkeys for a domain deployment of MultiPoint Services  
  
1.  Open Registry editor. (At a command prompt, type **regedit.exe**, and press ENTER.)  
  
2.  In the left pane, locate and then select the following registry subkey:  
  
    HKEY_USERS\<SIDofWMSshell>\Software\Policies\Microsoft\Windows\Control Panel\Desktop  
  
    where '<SIDofWMSshell>' is the security identifier (SID) for the WMSshell account. To find out how to identify the SID, see [How to Associate a Username with a Security Identifier (SID)](https://support.microsoft.com/kb/154599).  
  
3.  In the list on the right, update the following subkeys.  
  
    |Subkey|Value name|Value data|  
    |----------|--------------|--------------|  
    |ScreenSaveActive|REG_SZ|0 (zero)|  
    |ScreenSaveTimeout|REG_SZ|120|  
    |ScreenSaverIsSecure|REG_SZ|0 (zero)|  
  
    To update a Registry subkey:  
  
    1.  With the Registry key selected in the left pane, right-click the subkey in the right pane, and then click **Modify**.  
  
    2.  In the Edit String dialog box, type a new value in **Value data**, and then click **OK**.  
  
4.  After you finish updating Registry subkeys, restart the computer to activate the changes. 
