---
title: Set Access Scope for a DNS Zone
description: This topic is part of the IP Address Management (IPAM) Management guide in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ipam
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6a211dde-80eb-4888-b5bb-4e28fe8dc7df
ms.author: pashort
author: shortpatti
---
# Set Access Scope for a DNS Zone

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to set the access scope for a DNS zone by using the IPAM client console.  
  
Membership in **Administrators**, or equivalent, is the minimum required to perform this procedure.  
  
### To set the access scope for a DNS zone  
  
1.  In Server Manager, click  **IPAM**. The IPAM client console appears.  
  
2.  In the navigation pane, click **DNS Zones**. In the display pane, right-click the DNS zone for which you want to change the access scope., and then click **Set Access Scope**.  
  
    ![Set Access Scope](../../media/Set-Access-Scope-for-a-DNS-Zone/ipam_SetAccessScopeOfZone_02.jpg)  
  
3.  The **Set Access Scope** dialog box opens. If required for your deployment, click to deselect **Inherit access scope from parent**. In **Select the access scope**, select an item, and then click **OK**.  
  
    ![Select the access scope](../../media/Set-Access-Scope-for-a-DNS-Zone/ipam_SetAccessScopeOfZone_03.jpg)  
  
4.  In the IPAM client console display pane, verify that the access scope for the zone is changed.  
  
    ![Verify that the access scope for the zone is changed](../../media/Set-Access-Scope-for-a-DNS-Zone/ipam_SetAccessScopeOfZone_04.jpg)  
  
## See Also  
[Role-based Access Control](Role-based-Access-Control.md)  
[Manage IPAM](Manage-IPAM.md)  
  


