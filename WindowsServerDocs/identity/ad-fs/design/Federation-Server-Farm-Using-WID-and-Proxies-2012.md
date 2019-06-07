---
ms.assetid: 8890ccc9-068d-4da2-bd51-8a2964173ff1
title: Federation Server Farm Using WID and Proxies
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Federation Server Farm Using WID and Proxies

This deployment topology for Active Directory Federation Services \(AD FS\) is identical to the federation server farm with Windows Internal Database \(WID\) topology, but it adds federation server proxies to the perimeter network to support external users. The federation server proxies redirect client authentication requests that come from outside your corporate network to the federation server farm.  
  
## Deployment considerations  
This section describes various considerations about the intended audience, benefits, and limitations that are associated with this deployment topology.  
  
### Who should use this topology?  
  
-   Organizations with 100 or fewer configured trust relationships that need to provide both their internal users and external users \(who are logged on to computers that are physically located outside the corporate network\) with single sign\-on \(SSO\) access to federated applications or services  
  
-   Organizations that need to provide both their internal users and external users with SSO access to Microsoft Office 365  
  
-   Smaller organizations that have external users and require redundant, scalable services  
  
### What are the benefits of using this topology?  
  
-   The same benefits as listed for the [Federation Server Farm Using WID](Federation-Server-Farm-Using-WID-2012.md) topology, plus the benefit of providing additional access for external users  
  
### What are the limitations of using this topology?  
  
-   The same limitations as listed for the [Federation Server Farm Using WID](Federation-Server-Farm-Using-WID-2012.md) topology  
  
## Server placement and network layout recommendations  
To deploy this topology, in addition to adding two federation server proxies, you must make sure that your perimeter network can also provide access to a Domain Name System \(DNS\) server and to a second Network Load Balancing \(NLB\) host. The second NLB host must be configured with an NLB cluster that uses an Internet\-accessible cluster IP address, and it must use the same cluster DNS name setting as the previous NLB cluster that you configured on the corporate network \(fs.fabrikam.com\). The federation server proxies should also be configured with Internet\-accessible IP addresses.  
  
The following illustration shows the existing federation server farm with WID topology that was described previously and how the fictional Fabrikam, Inc., company provides access to a perimeter DNS server, adds a second NLB host with the same cluster DNS name \(fs.fabrikam.com\), and adds two federation server proxies \(fsp1 and fsp2\) to the perimeter network.  
  
![server farm using WID](media/FarmWIDProxies.gif)  
  
For more information about how to configure your networking environment for use with federation servers or federation server proxies, see either [Name Resolution Requirements for Federation Servers](Name-Resolution-Requirements-for-Federation-Servers.md) or [Name Resolution Requirements for Federation Server Proxies](Name-Resolution-Requirements-for-Federation-Server-Proxies.md).  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
