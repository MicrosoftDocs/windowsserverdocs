---
ms.assetid: f775cbda-a75d-439d-9aa7-82f3bc8dc932
title: Federation Server Farm Using WID
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Federation Server Farm Using WID

The default topology for Active Directory Federation Services \(AD FS\) is a federation server farm, using the Windows Internal Database \(WID\). In this topology, AD FS uses WID as the store for the AD FS configuration database for all federation servers that are joined to that farm. The farm replicates and maintains the Federation Service data in the configuration database across each server in the farm. AD FS in Windows Server 2012 R2 enables organizations with 100 or fewer relying party trusts to configure federation server farms using WID with up to 30 servers.  
  
The act of creating the first federation server in a farm also creates a new Federation Service. When you use WID for the AD FS configuration database, the first federation server that you create in the farm is referred to as the *primary federation server*. This means that this computer is configured with a read\/write copy of the AD FS configuration database.  
  
All other federation servers that you configure for this farm are referred to as *secondary federation servers* because they must replicate any changes that are made on the primary federation server to the read\-only copies of the AD FS configuration database that they store locally.  
  
> [!IMPORTANT]  
> We recommend the use of at least two federation servers in a load\-balanced configuration.  
  
## Deployment considerations  
This section describes various considerations about the intended audience, benefits, and limitations that are associated with this deployment topology.  
  
### Who should use this topology?  
  
-   Organizations with 100 or fewer configured trust relationships that need to provide their internal users \(logged on to computers that are physically connected to the corporate network\) with single sign\-on \(SSO\) access to federated applications or services  
  
-   Organizations that want to provide their internal users with SSO access to Microsoft Online Services or Microsoft Office 365  
  
-   Smaller organizations that require redundant, scalable services  
  
> [!NOTE]  
> Organizations with larger databases should consider using the [Federation Server Farm Using SQL Server](Federation-Server-Farm-Using-SQL-Server.md) deployment topology. Organizations with users who log in from outside the network should consider using either the [Federation Server Farm Using WID and Proxies](Federation-Server-Farm-Using-WID-and-Proxies.md) topology or the [Federation Server Farm Using SQL Server](Federation-Server-Farm-Using-SQL-Server.md) topology.  
  
### What are the benefits of using this topology?  
  
-   Provides SSO access to internal users  
  
-   Data and Federation Service redundancy \(each federation server replicates changes to other federation servers in the same farm\)  
  
-   WID is included with Windows; therefore, no need to purchase SQL Server  
  
### What are the limitations of using this topology?  
  
-   A WID farm has a limit of 30 federation servers if you have 100 or fewer relying party trusts.  
  
-   A WID farm does not support token replay detection or artifact resolution \(part of the Security Assertion Markup Language \(SAML\) protocol\).  
  
The following table provides a summary for using a WID farm.  Use it to plan your implementation.  
  
|| 1 \- 100 RP Trusts | More than 100 RP Trusts |
| --- | --- | --- |
|1 \- 30 AD FS Nodes|WID Supported|Not supported using WID - SQL Required 
|More than 30 AD FS Nodes|Not supported using WID - SQL Required|Not supported using WID - SQL Required  
  
## Server placement and network layout recommendations  
When you are ready to start deploying this topology in your network, you should plan on placing all of the federation servers in your corporate network behind a Network Load Balancing \(NLB\) host that can be configured for an NLB cluster with a dedicated cluster Domain Name System \(DNS\) name and cluster IP address.  
  
> [!NOTE]  
> This cluster DNS name must match the Federation Service name, for example, fs.fabrikam.com.  
  
The NLB host can use the settings that are defined in this NLB cluster to allocate client requests to the individual federation servers. The following illustration shows how the fictional Fabrikam, Inc., company sets up the first phase of its deployment using a two\-computer federation server farm \(fs1 and fs2\) with WID and the positioning of a DNS server and a single NLB host that is wired to the corporate network.  
  
![server farm using WID](media/FarmWID.gif)  
  
> [!NOTE]  
> If there is a failure on this single NLB host, users will not be able to access federated applications or services. Add additional NLB hosts if your business requirements do not allow having a single point of failure.  
  
For more information about how to configure your networking environment for use with federation servers, see the Name Resolution Requirements section in [AD FS Requirements](AD-FS-Requirements.md).  
  
## See Also  
[Plan Your AD FS Deployment Topology](Plan-Your-AD-FS-Deployment-Topology.md)  
[AD FS Design Guide in Windows Server 2012 R2](AD-FS-Design-Guide-in-Windows-Server-2012-R2.md)  
  

