---
title: Federation Server Farm Using WID and Proxies
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a2a3603a-186a-47f5-8ffa-d2ae2feea7b5
author: billmath
---
# Federation Server Farm Using WID and Proxies
This deployment topology for [!INCLUDE[firstref_adfs2]()] is identical to the federation server farm with Windows Internal Database \(WID\) topology, but it adds federation server proxies to the perimeter network to support external users. The federation server proxies redirect client authentication requests that come from outside your corporate network to the federation server farm.  
  
## Deployment considerations  
This section describes various considerations about the intended audience, benefits, and limitations that are associated with this deployment topology.  
  
### Who should use this topology?  
  
-   Organizations with 100 or fewer configured trust relationships that need to provide both their internal users and external users \(who are logged on to computers that are physically located outside the corporate network\) with single sign\-on \(SSO\) access to federated applications or services  
  
-   Organizations that need to provide both their internal users and external users with SSO access to Microsoft Office 365  
  
-   Smaller organizations that have external users and require redundant, scalable services  
  
### What are the benefits of using this topology?  
  
-   The same benefits as listed for the [Federation Server Farm Using WID](../../../../active-directory-federation-services/plan/WS2012-guide/topology/../../../../active-directory-federation-services/plan/WS2012-guide/topology/Federation-Server-Farm-Using-WID.md) topology, plus the benefit of providing additional access for external users  
  
### What are the limitations of using this topology?  
  
-   The same limitations as listed for the [Federation Server Farm Using WID](../../../../active-directory-federation-services/plan/WS2012-guide/topology/../../../../active-directory-federation-services/plan/WS2012-guide/topology/Federation-Server-Farm-Using-WID.md) topology  
  
## Server placement and network layout recommendations  
To deploy this topology, in addition to adding two federation server proxies, you must make sure that your perimeter network can also provide access to a Domain Name System \(DNS\) server and to a second Network Load Balancing \(NLB\) host. The second NLB host must be configured with an NLB cluster that uses an Internet\-accessible cluster IP address, and it must use the same cluster DNS name setting as the previous NLB cluster that you configured on the corporate network \(fs.fabrikam.com\). The federation server proxies should also be configured with Internet\-accessible IP addresses.  
  
The following illustration shows the existing federation server farm with WID topology that was described previously and how the fictional Fabrikam, Inc., company provides access to a perimeter DNS server, adds a second NLB host with the same cluster DNS name \(fs.fabrikam.com\), and adds two federation server proxies \(fsp1 and fsp2\) to the perimeter network.  
  
![](../../../../media/Federation-Server-Farm-Using-WID-and-Proxies/FarmWIDProxies.gif)  
  
For more information about how to configure your networking environment for use with federation servers or federation server proxies, see either [Name Resolution Requirements for Federation Servers]() or [Name Resolution Requirements for Federation Server Proxies]().  
  

