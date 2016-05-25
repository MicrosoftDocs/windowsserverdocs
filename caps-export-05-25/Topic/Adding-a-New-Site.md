---
title: Adding a New Site
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 838b7284-4651-4458-aed0-81fd6ca4f094
author: Femila
---
# Adding a New Site
  Design teams or network architects might want to add site objects in Active Directory Domain Services \(AD DS\) as part of ongoing deployment. Although you typically create subnets to accommodate all address ranges in the network, you do not have to create sites for every location. Generally, sites are required for those locations that have domain controllers or other servers that run applications, such as Distributed File System \(DFS\), that depend on site topology.  
  
 When a site is needed, the design team typically provides details about the placement and configuration of site links for the new site, as well as subnet assignments or creation if subnets are needed.  
  
 If a new range of IP addresses is added to the network, create a subnet object in AD DS to correspond to the range of IP addresses. When you use Active Directory Sites and Services to create a new subnet object, you are required to associate the subnet with a site object. You can either associate the subnet with an existing site or create a new site first and then create the subnet and associate it with the new site. If a domain client has an IP address that does not map to a site, the client might be connected to a domain controller that is potentially far away from the client, causing slow responses for the client.  
  
> [!NOTE]  
>  When a domain client that has an IP address in a subnet that is not defined in AD DS connects to a domain controller, NETLOGON Event ID 5807 is generated in the System event log. The event indicates that clients have connected to the domain controller with IP addresses that do not map to a site. The text in the event provides instructions for determining the names and IP addresses of the client computers by searching the Netlogon.log file.  
  
 **Task requirements**  
  
 The following is required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
 To complete this task, perform the following procedures:  
  
1.  [Create a Site Object and Add it to an Existing Site Link](../Topic/Create-a-Site-Object-and-Add-it-to-an-Existing-Site-Link.md)  
  
2.  Associate a range of IP addresses with the site by using either of the following methods:  
  
    -   [Create a Subnet Object or Objects and Associate them with a Site](../Topic/Create-a-Subnet-Object-or-Objects-and-Associate-them-with-a-Site.md)  
  
    -   [Associate an Existing Subnet Object with a Site](../Topic/Associate-an-Existing-Subnet-Object-with-a-Site.md)  
  
3.  If you are creating both a new site and a new site link, after you create the new site and add it to an existing site link, [Create a Site Link Object and Add the Appropriate Sites](../Topic/Create-a-Site-Link-Object-and-Add-the-Appropriate-Sites.md). Then, remove the site from the first site link that you added it to when you created the site, if appropriate.  
  
4.  [Remove a Site from a Site Link](../Topic/Remove-a-Site-from-a-Site-Link.md)  
  
  