---
title: Configure Windows Firewall to Suppress Notifications When a Program Is Blocked
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b37c1db0-c93f-47c0-8406-e877f8293068
author: vhorne
---
# Configure Windows Firewall to Suppress Notifications When a Program Is Blocked
To configure Windows Firewall to suppress the display of a notification when it blocks a program that tries to listen for network traffic and to prohibit locally defined rules, use the [!INCLUDE[wfas](../Token/wfas_md.md)] node  in the Group Policy Management MMC snap\-in.  
  
> [!CAUTION]  
> If you choose to disable alerts and prohibit locally defined rules, then you must create firewall rules that allow your users’ programs to send and receive the required network traffic. If a firewall rule is missing, then the user does not receive any kind of warning, the network traffic is silently blocked, and the program might fail.  
>   
> We recommend that you do not enable these settings until you have created and tested the required rules.  
  
**Administrative credentials**  
  
To complete these procedures, you must be a member of the Domain Administrators group, or otherwise be delegated permissions to modify the GPOs.  
  
In this topic:  
  
[To configure Windows Firewall to suppress the display of a notification for a blocked program and to ignore locally defined rules on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008 or Windows Server 2008 R2](#bkmk_1)  
  
## <a name="bkmk_1"></a>  
#### To configure Windows Firewall to suppress the display of a notification for a blocked program and to ignore locally defined rules on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008 or Windows Server 2008 R2  
  
1.  [Open the Group Policy Management Console to Windows Firewall with Advanced Security](../Topic/Open-the-Group-Policy-Management-Console-to-Windows-Firewall-with-Advanced-Security.md).  
  
2.  In the details pane, in the **Overview** section, click **Windows Firewall Properties**.  
  
3.  For each network location type \(Domain, Private, Public\), perform the following steps.  
  
    1.  Click the tab that corresponds to the network location type.  
  
    2.  Under **Settings**, click **Customize**.  
  
    3.  Under **Firewall settings**, change **Display a notification** to **No**.  
  
    4.  Under **Rule merging**, change **Apply local firewall rules** to **No**.  
  
    5.  Although a connection security rule is not a firewall setting, you can also use this tab to prohibit locally defined connection security rules if you are planning to deploy IPsec rules as part of a server or domain isolation environment. Under **Rule merging**, change **Apply local connection security rules** to **No**.  
  
    6.  Click **OK** twice.  
  
