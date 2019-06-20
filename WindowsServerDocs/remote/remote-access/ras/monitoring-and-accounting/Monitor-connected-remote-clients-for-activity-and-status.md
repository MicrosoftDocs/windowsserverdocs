---
title: Monitor connected remote clients for activity and status
description: This topic is part of the guide for Remote Access Monitoring and Accounting in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: beb94475-b21f-46a9-ac51-bf2bb28ca94e
ms.author: pashort
author: shortpatti
---
# Monitor connected remote clients for activity and status

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

**Note:** Windows Server 2012 combines DirectAccess and Remote Access Service (RAS) into a single Remote Access role.  
  
You can use the management console on the Remote Access server to monitor remote client activity and status.  
  
> [!NOTE]  
> You must be signed in as a member of the Domain Admins group or a member of the Administrators group on each computer to complete the tasks described in this topic. If you cannot complete a task while you are signed in with an account that is a member of the Administrators group, try performing the task while you are signed in with an account that is a member of the Domain Admins group.  
  
#### To monitor remote client activity and status  
  
1.  In **Server Manager**, click **Tools**, and then click **Remote Access Management**.  
  
2.  Click **REPORTING** to navigate to **Remote Access Reporting** in the **Remote Access Management Console**.  
  
3.  Click **Remote Client Status** to navigate to the remote client activity and status user interface in the **Remote Access Management Console**.  
  
4.  You will see the list of users who are connected to the Remote Access server and detailed statistics about them. Click the first row in the list that corresponds to a client. When you select a row, the remote user activity is shown in the preview pane.  
  
![Windows PowerShell](../../../media/Monitor-connected-remote-clients-for-activity-and-status/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
PS> Get-RemoteAccessConnectionStatistics  
```  
  
The user statistics can be filtered, based on criteria selections, by using the fields in the following table.  
  
|Field Name|Value|  
|-------|-----|  
|Username|The user name or alias of the remote user. Wildcard characters can be used to select a group of users, such as contoso\\* or \*\administrator.|  
|Hostname|The computer account name of the remote user. An IPv4 or IPv6 address also can be specified.|  
|Type|DirectAccess or VPN. If DirectAccess is selected, all remote users who are connected by using DirectAccess are listed. If VPN is selected, all remote users who are connected by using VPN are listed.|  
|ISP address|The IPv4 or IPv6 address of the remote user.|  
|IPv4 address|The inner IPv4 address of the tunnel that connect the remote user to the corporate network.|  
|IPv6 address|The inner IPv6 address of the tunnel that connects the remote user to the corporate network.|  
|Protocol/Tunnel|The transitioning technology that is used by the remote client. This is Teredo, 6to4, or IP-HTTPS for DirectAccess users, and it is PPTP, L2TP, SSTP, or IKEv2 for VPN users.|  
|Resource Accessed|All users who are accessing a particular corporate resource or an endpoint. The value that corresponds to this field is the hostname/IP address of the server.|  
|Server|The Remote Access server to which clients are connected. This is relevant only for cluster and multisite deployments.|  
  
  
  


