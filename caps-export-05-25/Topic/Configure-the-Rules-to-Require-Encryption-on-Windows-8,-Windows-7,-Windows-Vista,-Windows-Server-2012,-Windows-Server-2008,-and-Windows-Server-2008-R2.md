---
title: Configure the Rules to Require Encryption on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 93b19cfc-f609-4a40-b9f0-c5716b8da417
author: vhorne
---
# Configure the Rules to Require Encryption on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2
If you are creating a zone that requires encryption, you must configure the rules to add the encryption algorithms and delete the algorithm combinations that do not use encryption.  
  
**Administrative credentials**  
  
To complete this procedure, you must be a member of the Domain Administrators group, or otherwise be delegated permissions to modify the GPOs.  
  
### To modify an authentication request rule to also require encryption  
  
1.  [Open the Group Policy Management Console to Windows Firewall with Advanced Security](../Topic/Open-the-Group-Policy-Management-Console-to-Windows-Firewall-with-Advanced-Security.md).  
  
2.  In the navigation pane, click **Connection Security Rules**.  
  
3.  In the details pane, double\-click the connection security rule you want to modify.  
  
4.  On the **Name** page, rename the connection security rule, edit the description to reflect the new use for the rule, and then click **OK**.  
  
5.  In the navigation pane, right\-click **Windows Firewall with Advanced Security – LDAP:\/\/CN\={***guid***}**, and then click **Properties**.  
  
6.  Click the **IPsec Settings** tab.  
  
7.  Under **IPsec defaults**, click **Customize**.  
  
8.  Under **Data protection \(Quick Mode\)**, click **Advanced**, and then click **Customize**.  
  
9. Click **Require encryption for all connection security rules that use these settings**.  
  
    This disables the data integrity rules section. Make sure the **Data integrity and encryption** list contains all of the combinations that your client computers will use to connect to members of the encryption zone. The client computers receive their rules through the GPO for the zone to which they reside. You must make sure that those rules contain at least one of the data integrity and encryption algorithms that are configured in this rule, or the client computers in that zone will not be able to connect to computers in this zone.  
  
10. If you need to add an algorithm combination, click **Add**, and then select the combination of encryption and integrity algorithms. The options are described in [Configure Data Protection &#40;Quick Mode&#41; Settings on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2](../Topic/Configure-Data-Protection--Quick-Mode--Settings-on-Windows-8,-Windows-7,-Windows-Vista,-Windows-Server-2012,-Windows-Server-2008,-and-Windows-Server-2008-R2.md).  
  
    > [!NOTE]  
    > Not all of the algorithms available in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] can be selected in the [!INCLUDE[wfas](../Token/wfas_md.md)] user interface. To select them, you can use Windows PowerShell.  
    >   
    > Quick mode settings can also be configured on a per\-rule basis, but not by using the [!INCLUDE[wfas](../Token/wfas_md.md)] user interface. Instead, you can create or modify the rules by using Windows PowerShell.  
    >   
    > For more information, see [Windows Firewall with Advanced Security Administration with Windows PowerShell](../Topic/Windows-Firewall-with-Advanced-Security-Administration-with-Windows-PowerShell.md)  
  
11. During negotiation, algorithm combinations are proposed in the order shown in the list. Make sure that the more secure combinations are at the top of the list so that the negotiating computers select the most secure combination that they can jointly support.  
  
12. Click **OK** three times to save your changes.  
  
